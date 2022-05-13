{extends file="$layouts_client"}

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



            <div class="panel">
                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table table-striped filter-table" id="tbl_articles">
                                <thead>
                                <tr>
                                    <th>{$_L['Title']}</th>

                                </tr>
                                </thead>
                                <tbody>

                                {foreach $articles as $article}

                                    <tr>

                                        <td class="h5"><a href="{$_url}kb/{$article->slug}" id="k{$article->id}" class="kb_view">{$article->title}</a> </td>



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

    <script src="{$app_url}ui/lib/js/filtertable.js"></script>

    <script>
        $(function() {



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
