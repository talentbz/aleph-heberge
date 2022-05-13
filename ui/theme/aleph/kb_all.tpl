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



    <div class="row">
        <div class="col-md-12">

            <a href="{$_url}kb/a/edit" class="btn btn-primary mb-3">{$_L['New Article']}</a>

            <div class="panel">
                <div class="panel-container">
                    <div class="panel-content">
                        <div>
                            <table class="table table-striped filter-table" id="tbl_articles">
                                <thead>
                                <tr>
                                    <th>{$_L['Title']}</th>
                                    {if $can_edit || $can_delete}
                                        <th width="110px;">{$_L['Manage']}</th>
                                    {/if}
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $articles as $article}

                                    <tr>

                                        <td><a href="javascript:void(0)" id="k{$article['id']}" class="kb_view"><span class="h6">{$article['title']}</span></a> </td>

                                        {if $can_edit || $can_delete}

                                            <td class="text-right">


                                                {if $can_edit}
                                                    <a href="{$_url}kb/a/edit/{$article['id']}" class="btn btn-warning btn-icon"><i class="fal fa-pencil"></i> </a>
                                                {/if}
                                                {if $can_delete}
                                                    <button class="btn btn-danger btn-icon" onclick="deleteKb({$article['id']})" id="da{$article['id']}"><i class="fal fa-trash-alt"></i> </button>
                                                {/if}

                                            </td>

                                        {/if}



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
        function deleteKb(kbid) {
            bootbox.confirm(_L['are_you_sure'], function(result) {
                if(result){
                    window.location.href = base_url + "kb/a/delete/" + kbid;
                }
            });
        }

        $(function() {

            $(".kb_view").on('click',function (e) {
                e.preventDefault();
                iModal.ajax(base_url + "kb/a/a_view/"+this.id, $(this).html());
            });




            $('#tbl_articles').dataTable(
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


        });
    </script>
{/block}
