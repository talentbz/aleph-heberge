{extends file="$layouts_admin"}

{block name="content"}
    <div class="row" id="ib_editor_canvas">
        <div class="col-lg-2">
            <div class="panel">
                <div class="panel-container">
                    <div class="panel-content">
                        <div class="form-group">
                            <label for="editor_file">{$_L['File']}</label>
                            <select name="editor_file" id="editor_file" class="custom-select">
                                <option value="no_file" selected="selected" >{$_L['Select File to Edit']}</option>
                                <option value="language.php">{$_L['Language File']}</option>
                                <option value="invoice_printer.php">{$_L['Invoice Layout Print']}</option>
                                <option value="invoice_pdf.php">{$_L['Invoice Layout PDF']}</option>


                            </select>
                        </div>
                        <button type="submit" id="ib_btn_save" class="btn btn-primary"><i class="fal fa-check"></i> {$_L['Save']}</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-10">


            <div id="editor" style="min-height: 800px;"></div>



        </div>
    </div>
{/block}

{block name="script"}
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.11/ace.min.js" integrity="sha256-qCCcAHv/Z0u7K344shsZKUF2NR+59ooA3XWRj0LPGIQ=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.11/ext-modelist.min.js" integrity="sha256-6IKCjSdCwtsKc0jk/TvazSJQEBEZ0JdCgDVu8f7rXNE=" crossorigin="anonymous"></script>

    <script>
        $(function() {

            var _url = $("#_url").val();

            var $ib_editor_canvas = $("#ib_editor_canvas");

            ace.config.set("basePath", 'https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.11/');

            var editor = ace.edit("editor");
            editor.setTheme("ace/theme/monokai");
            editor.getSession().setMode("ace/mode/php");

            var $editor_file = $("#editor_file");

            var $ib_btn_save = $("#ib_btn_save");


            $editor_file.change(function() {

                $ib_editor_canvas.block({ message: block_msg });

                $.get( _url + "editor/" + $editor_file.val() + "/", function( data ) {
                    $ib_editor_canvas.unblock();
                    editor.$blockScrolling = Infinity;
                    editor.setValue(data, -1);
                    editor.setValue(data, 1);
                });




            });


            $ib_btn_save.on('click', function(e) {

                e.preventDefault();
                $ib_editor_canvas.block({ message: block_msg });

                var codes = editor.getValue();

                $.post( _url + "editor/save/", { file: $editor_file.val(), codes: codes })
                    .done(function( data ) {
                        $ib_editor_canvas.unblock();
                        toastr.success(data);

                    });

            });


        });
    </script>

{/block}
