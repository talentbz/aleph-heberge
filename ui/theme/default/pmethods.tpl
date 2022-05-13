{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="widget-1 col-md-6 col-sm-12">
            <div class="panel">
                <div class="panel-hdr">

                    <h2 class="panel-title">{$_L['Add']}</h2>
                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <form role="form" name="accadd" method="post" action="{$_url}settings/pmethods-post">
                            <div class="form-group">
                                <label for="name">{$_L['Name']}</label>
                                <input type="text" class="form-control" id="name" name="name">
                            </div>




                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </form>
                    </div>

                </div>
            </div>
        </div> <!-- Widget-1 end-->
        <div class="widget-1 col-md-6 col-sm-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2 class="panel-title">{$_L['Manage Payment Methods']}</h2>
                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <span id="resp">{$_L['drag_n_drop_help']}</span>
                        <ol class="rounded-list" id="sorder">


                            {foreach $d as $ds}
                                <li id='recordsArray_{$ds['id']}'><a href="{$_url}settings/pmethods-manage/{$ds['id']}">{$ds['name']}</a></li>
                            {/foreach}

                        </ol>
                    </div>


                </div>
            </div>
        </div>
        <!-- Widget-2 end-->
    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            $(function() {
                $("#sorder").sortable({ opacity: 0.6, cursor: 'move', update: function() {
                        var order = $(this).sortable("serialize") + '&action=sys_pmethods';
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
