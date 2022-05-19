{extends file="hostbilling/layouts/new_base/base.tpl"}

{block name="head"}

    <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app.min.css?v={{_raid()}}">
    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }

        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600!important;
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


{block name="new_content"}
<main id="clx-page-content" role="main" class="page-content">
    <div class="panel">
        <div class="panel-hdr">
            <h2 class="h2">{$_L['Total']} : {$total_quotes}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">

                <div class="table-responsive">
                    <table class="table  table-striped table-hover sys_table">
                        <thead>
                        <tr>

                            <th width="30%">{$_L['Subject']}</th>
                            <th>{$_L['Amount']}</th>
                            <th>{$_L['Date Created']}</th>
                            <th>{$_L['Expiry Date']}</th>
                            {*<th>{$_L['Stage']}</th>*}

                            <th class="text-right">{$_L['Manage']}</th>
                        </tr>
                        </thead>
                        <tbody>

                        {foreach $d as $ds}
                            <tr>

                                <td class="h5"><a href="{$_url}client/q/{$ds['id']}/token_{$ds['vtoken']}/" target="_blank">{$ds['subject']}</a> </td>
                                <td class="amount">{$ds['total']}</td>
                                <td>{date( $config['df'], strtotime($ds['datecreated']))}</td>
                                <td>{date( $config['df'], strtotime($ds['validuntil']))}</td>


                                <td class="text-right">
                                    <div class="btn-group">
                                        <a href="{$_url}client/q/{$ds['id']}/token_{$ds['vtoken']}/" target="_blank" class="btn btn-primary"><i class="fal fa-check"></i></a>

                                        <a href="{$_url}client/qpdf/{$ds['id']}/token_{$ds['vtoken']}/dl/" class="btn btn-success " ><i class="fal fa-file"></i> </a>
                                        <a href="{$_url}client/qpdf/{$ds['id']}/token_{$ds['vtoken']}/" target="_blank" class="btn btn-warning"><i class="fal fa-print"></i> </a>
                                    </div>
                                </td>
                            </tr>

                            {foreachelse}

                            <tr>
                                <td colspan="7">
                                    {$_L['No Data Available']}
                                </td>
                            </tr>

                        {/foreach}

                        </tbody>
                    </table>
                </div>


            </div>

        </div>

    </div>
</main>
{/block}