{extends file="$layouts_admin"}

{block name="head"}


    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }

        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600;
            line-height: 1.5;
            margin-bottom: .5rem;
            color: #32325d;
        }
        .text-info{
            color: #6772E5!important;
        }
        .text-success{
            color: #2CCE89!important;}

        .text-danger{
            color: #F6365B!important;
        }
        .text-warning{
            color: #FB6340!important;
        }
        .text-primary{
            color: #10CDEF!important;
        }
    </style>
{/block}


{block name="content"}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>
                        {$_L['Email Templates']}
                    </h2>

                    <div class="panel-toolbar">
                        <a href="#" id="add_new_template" class="btn btn-primary">{$_L['Add New Template']}</a>
                    </div>




                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <div class="mail-box" id="application_ajaxrender">

                            <table class="table table-hover table-striped" id="tbl_email_templates">
                                <thead>
                                <tr class="heading">
                                    <th>{$_L['Name']}</th>
                                    <th>{$_L['Subject']}</th>
                                    <th>{$_L['Status']}</th>
                                    <th class="text-right" style="width: 80px;">{$_L['Manage']}</th>
                                </tr>


                                </thead>
                                <tbody>
                                {foreach $d as $ds}
                                    <tr class="read">

                                        <td><a  class="ve h6" id="f{$ds['id']}" href="#">{ib_lan_get_line($ds['tplname'])}</a>  </td>
                                        <td><a  class="ve h6 text-info" id="s{$ds['id']}" href="#">{$ds['subject']}</a></td>
                                        <td class="text-right">
                                            {if $ds['send'] eq 'Yes'}
                                                <span class="badge badge-success"> {$_L['Active']} </span>
                                            {else}
                                                <span class="badge badge-danger"> {$_L['Inactive']} </span>
                                            {/if}
                                            &nbsp;
                                            {if $ds['core'] eq 'Yes'}
                                                <span class="badge badge-warning"> {$_L['System']} </span>
                                            {else}
                                                <span class="badge badge-info"> {$_L['Custom']} </span>
                                            {/if}

                                        </td>

                                        <td class="text-right">

                                            <div class="btn-group">
                                                <a href="javascript:void(0)" class="btn btn-primary btn-sm ve" id="b{$ds['id']}" data-toggle="tooltip" data-placement="top" title="{$_L['View']}"><i class="fal fa-file-alt"></i></a>
                                                <a href="{$_url}settings/clone_email_template/{$ds['id']}/" class="btn btn-success btn-sm" data-toggle="tooltip" data-placement="top" title="{$_L['Clone']}"><i class="fal fa-file-edit"></i></a>


                                                {if $ds['core'] neq 'Yes'}
                                                    <a href="javascript:void(0)" class="btn btn-danger btn-sm cdelete" id="ed{$ds['id']}" data-toggle="tooltip" data-placement="top" title="{$_L['Delete']}"><i class="fal fa-trash-alt"></i></a>
                                                {/if}

                                            </div>

                                        </td>

                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>


                        </div>
                    </div>

                </div>

            </div>
        </div>



    </div>



{/block}

{block name="script"}
    <script>
        $(function () {

            $('#tbl_email_templates').dataTable(
                {
                    responsive: true,
                    "language": {
                        "emptyTable": "{$_L['No items to display']}",
                        "info":      "{$_L['Showing _START_ to _END_ of _TOTAL_ entries']}",
                        "infoEmpty":      "{$_L['Showing 0 to 0 of 0 entries']}",
                        buttons: {
                            pageLength: '{$_L['Show all']}'
                        },
                        searchPlaceholder: "{__('Search')}"
                    },
                }
            );

            var $modal = $('#cloudonex_body');
            var sysrender = $modal;

            var _url = base_url;

            var page_refresh = false;



            sysrender.on('click', '.ve', function(e){
                e.preventDefault();
                var vid = this.id;
                var id = vid.replace("f", "");
                id = id.replace("s", "");
                id = id.replace("b", "");



                $.fancybox.open({
                    src  : base_url + 'settings/email-templates-view/' + id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    }
                });

            });


            $modal.on('click', '#update', function(){

                page_refresh = true;

                $.post(base_url + 'settings/update-email-template', {


                    message: $('#message').val(),
                    subject: $('#subject').val(),
                    tplname: $('#tplname').val(),

                    id: $('#sid').val(),
                    send: $('#send').val()

                }).done(function (data) {
                    location.reload();
                });

            });



            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        window.location.href = base_url + "delete/email-templates/" + id + '/';
                    }
                });
            });


            $("#add_new_template").on('click', function(e) {
                e.preventDefault();

                $.fancybox.open({
                    src  : base_url + 'settings/email-templates-view/',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    }
                });

            });

        })
    </script>
{/block}
