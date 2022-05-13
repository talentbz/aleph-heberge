{extends file="$layouts_admin"}
{block name="head"}

    {if empty($config['admin_dark_theme'])}
        <style>
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #F7F9FC;
            }
        </style>
    {/if}

{/block}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Groups']}</h2>
                    <div class="panel-toolbar">
                        <div class="btn-group">
                            <a href="#" class="btn btn-sm btn-success" id="add_new_group"><i class="fal fa-plus"></i> {$_L['Add New Group']}</a>
                            <a href="{$_url}reorder/groups/" class="btn btn-sm btn-primary"><i class="fal fa-download"></i> {$_L['Reorder']}</a>
                        </div>


                    </div>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <div class="thead-light">
                            <table class="table table-striped">
                                <th><strong>{$_L['Group']}</strong></th>
                                <th class="float-right">{$_L['Manage']}</th>
                                {foreach $gs as $g}
                                    <tr>
                                        <td><strong>{$g['gname']}</strong></td>

                                         <td>
                                             <div class="btn-group float-right">
                                                 <a href="{$_url}contacts/find_by_group/{$g['id']}/" class="btn btn-sm btn-primary"> {$_L['List Contacts']}</a>
                                                 <a href="#" class="btn btn-sm btn-warning edit_group" id="e{$g['id']}" data-name="{$g['gname']}"> {$_L['Edit']}</a>

                                                 <a href="{$_url}settings/users-delete/{$g['id']}" id="g{$g['id']}" class="btn btn-sm btn-danger cdelete"> {$_L['Delete']}</a>
                                             </div>


                                        </td>
                                    </tr>
                                {/foreach}


                            </table>
                        </div>



                    </div>

                    <br>
                    <br>


                </div>
            </div>



        </div>



    </div>

    <input type="hidden" name="_msg_add_new_group" id="_msg_add_new_group" value="{$_L['Add New Group']}">
    <input type="hidden" name="_msg_group_name" id="_msg_group_name" value="{$_L['Group Name']}">
    <input type="hidden" name="_msg_edit" id="_msg_edit" value="{$_L['Edit']}">
    <input type="hidden" name="_msg_ok" id="_msg_ok" value="{$_L['OK']}">
    <input type="hidden" name="_msg_cancel" id="_msg_cancel" value="{$_L['Cancel']}">


{/block}

{block name="script"}

    <script>

        $(document).ready(function () {

            var _url = $("#_url").val();








            var _msg_add_new_group = $("#_msg_add_new_group").val();
            var _msg_group_name = $("#_msg_group_name").val();
            var _msg_edit = $("#_msg_edit").val();
            var _msg_ok = $("#_msg_ok").val();
            var _msg_cancel = $("#_msg_cancel").val();


            var ib_form_bootbox = "<form class=\"form-horizontal push-10\" method=\"post\" onsubmit=\"return false;\">\n    <div class=\"form-group\">\n        <div class=\"col-xs-12\">\n            <div class=\"form-material floating\">\n                <input class=\"form-control\" type=\"text\" id=\"group_name\" name=\"group_name\">\n                <label for=\"envato_api_key\">" + _msg_group_name + "</label>\n                           </div>\n        </div>\n    </div>\n\n</form>";


            var box =   bootbox.dialog({
                    title: _msg_add_new_group,
                    message: ib_form_bootbox,
                    buttons: {
                        success: {
                            label: "Save",
                            className: "btn-primary",
                            callback: function () {
                                // var name = $('#name').val();
                                // var answer = $("input[name='awesomeness']:checked").val();
                                // Example.show("Hello " + name + ". You've chosen <b>" + answer + "</b>");

                                var group_name_val = $('#group_name').val();

                                $.post(  _url + "contacts/add_group/", { group_name: group_name_val })
                                    .done(function( data ) {

                                        if ($.isNumeric(data)) {

                                            location.reload();

                                        }

                                        else {
                                            bootbox.alert(data);
                                        }

                                    });


                            }
                        }
                    },
                    show: false
                }
            );





            $("#add_new_group").click(function(e){

                e.preventDefault();

                box.modal('show');


            });


            box.on("shown.bs.modal", function() {

                var group_name = $('#group_name');
                setTimeout(function(){
                    group_name.focus();
                }, 1000);

            });


            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/crm-group/" + id;
                    }
                });
            });


            $(".edit_group").click(function (e) {
                e.preventDefault();

                var eid = this.id;

                // alert(eid);

                var gname = $( this ).attr( "data-name" );





                bootbox.prompt({
                    title: _msg_edit,
                    value: gname,
                    buttons: {
                        'cancel': {
                            label: _msg_cancel
                        },
                        'confirm': {
                            label: _msg_ok
                        }
                    },
                    callback: function(result) {
                        if (result === null) {

                        } else {
                            // alert(result);
                            $.post(  _url + "contacts/group_edit/", { id: eid, gname: result })
                                .done(function( data ) {
                                    location.reload();
                                });
                        }
                    }
                });

            });




        });
    </script>
{/block}
