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

    </style>
{/block}


{block name="content"}


    <div class="row kb-page">

        <div class="col-md-8" id="kb_add_area">
            <div class="panel">

                <div class="panel-hdr">
                    <h2>{$_L['Add New Article']}</h2>
                </div>


                <div class="panel-container">
                    <div class="panel-content">


                        <form id="ib_form" class="form-horizontal push-10-t push-10" method="post">

                            <div class="form-group">
                                <div class="col-xs-12">
                                    <div class="form-material floating">

                                        <label for="title">{$_L['Title']}</label>

                                        <input class="form-control" type="text" id="title" name="title" value="{$val['title']}" autofocus>


                                    </div>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-xs-12">
                                    <textarea class="form-control" id="description" name="description" rows="3">{$val['description']}</textarea>
                                </div>
                            </div>





                            <div class="form-group">
                                <div class="col-xs-12">




                                    {*<input type="hidden" name="attachments" id="attachments" value="">*}

                                    <input type="hidden" name="kbid" id="kbid" value="{$val['id']}">

                                    <button class="btn btn-primary" id="ib_form_submit" type="submit"><i class="fal fa-send push-5-r"></i> {$_L['Save']}</button>
                                </div>
                            </div>
                        </form>


                    </div>
                </div>

            </div>
        </div>

        <div class="col-md-4">

            <div class="panel">

                <div class="panel-hdr">
                    <h2>{$_L['Group']}</h2>
                </div>

                <div class="panel-container">
                    <div class="panel-content">


                        <form id="ib_add_group" class="form-horizontal push-10-t push-10" method="post">

                            <div class="form-group">
                                <div class="col-xs-12">
                                    <div class="form-material floating">
                                        <label for="gname">{$_L['Group Name']}</label>
                                        <input class="form-control" type="text" id="gname" name="gname">

                                    </div>
                                </div>
                            </div>



                            <div class="form-group">
                                <div class="col-xs-12">
                                    <button class="btn btn-primary" id="ib_add_group_submit" type="submit">{$_L['Save']}</button>
                                </div>
                            </div>
                        </form>


                        <div id="div_groups" class="mt-3">

                        </div>



                    </div>
                </div>


            </div>

            <div class="panel panel-default">

                <div class="panel-hdr">
                    <h2>{$_L['Latest Articles']}</h2>
                </div>

                <div class="panel-container">
                    <div class="panel-content">


                        <div>

                            <ul class="list-group">

                                {foreach $kbs as $kb}

                                    <li class="list-group-item"><a href="javascript:void(0)" id="k{$kb['id']}" class="kb_view h6"> {$kb['title']} </a></li>

                                {/foreach}

                            </ul>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>


{/block}

{block name="script"}



    <script>
        function deleteKb(kbid) {
            bootbox.confirm(_L['are_you_sure'], function(result) {
                if(result){
                    window.location.href = base_url + "kb/a/delete/" + kbid;
                }
            });
        }

        function loadKbGroups() {

            var $div_groups = $("#div_groups");

            $div_groups.html();

            $.get( base_url + "kb/a/ajax_groups/"+$("#kbid").val(), function( data ) {

                $div_groups.html(data);

            });

        }

        $(function() {

            loadKbGroups();

            $('#description').redactor(
                {
                    minHeight: 200 // pixels
                }
            );

            var ib_form_submit = $("#ib_form_submit");

            var kb_add_area = $("#kb_add_area");

            ib_form_submit.on('click', function(e) {
                e.preventDefault();
                kb_add_area.block({ message: block_msg });
                var selected_groups = [];

                $('.clx_input_groups').filter(':checked').each(function() {
                    selected_groups.push(this.id);
                });


                $.post( base_url + "kb/a/save/", { title: $("#title").val(), description: $('#description').val(), kbid: $("#kbid").val(),groups: selected_groups })
                    .done(function (data) {
                        if ($.isNumeric(data)) {

                            window.location = base_url + 'kb/a/edit/' + data;

                        }
                        else {
                            kb_add_area.unblock();
                            toastr.error(data);

                        }
                    });

            });


            $(".kb_view").on('click',function (e) {
                e.preventDefault();


                $.fancybox.open({
                    src  :  base_url + "kb/a/a_view/"+this.id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {

                        }
                    },
                });

            });

            $("#ib_add_group_submit").on('click',function (e) {
                e.preventDefault();

                $("#ib_add_group").block();

                $.post(base_url + 'kb/a/group_create/', { gname: $("#gname").val()}, function (data) {

                    $("#ib_add_group").unblock();

                    $("#gname").val('');

                    loadKbGroups();

                })

            })


        });
    </script>
{/block}
