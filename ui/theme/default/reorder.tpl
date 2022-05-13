{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Reorder']} {$ritem} {$_L['Positions']}</h2>

                </div>

                <div class="panel-container">
                    <div class="panel-content">


                        <h3 id="resp">{$_L['drag_n_drop_help']}</h3>
                        <div class="hr-line-dashed"></div>
                        <ol class="rounded-list" id="sorder">


                            {foreach $d as $ds}
                                <li id='recordsArray_{$ds['id']}'><a href="javascript:void(0)">{$ds[$display_name]}</a></li>
                            {/foreach}

                        </ol>

                    </div>
                </div>

            </div>



        </div>



    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            $(function() {
                $("#sorder").sortable({ opacity: 0.6, cursor: 'move', update: function() {
                        var order = $(this).sortable("serialize") + '&action={$action}';
                        $("#resp").html('Saving...');
                        $.post("{$_url}reorder/reorder-post", order, function(theResponse){
                            $("#resp").html(theResponse);
                        });
                    }
                });
            });
        });
    </script>
{/block}
