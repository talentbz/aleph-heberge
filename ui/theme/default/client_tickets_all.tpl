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
            font-weight: 600;
            line-height: 1.5;
            margin-bottom: .5rem;
            color: #32325d;
        }
        .text-info{
            color: #6772E5!important;
        }
        .text-success{
            color: #2CCE89!important;
        }
    </style>
{/block}
{block name="new_content"}
<main id="clx-page-content" role="main" class="page-content">
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['List Tickets']}</h2>
                    <div class="panel-toolbar">
                        <a href="{$_url}client/tickets/new/" class="btn pull-right btn-primary"><i class="icon-mail"></i> {$_L['Open New Ticket']}</a>
                    </div>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <table class="table table-hover table-vcenter">
                            <tbody>

                            {foreach $ds as $d}
                                <tr>
                                    <td class="text-center h5" style="width: 140px;"><a href="{$_url}client/tickets/view/{$d['tid']}/">#{$d['tid']}</a></td>
                                    <td class="hidden-xs hidden-sm hidden-md text-center" style="width: 100px;">
                                    <span class="badge badge-success">{if isset($_L[$d['status']])}
                                    {$_L[$d['status']]}
                                    {else}
                                    {$d['status']}
                                    {/if}</span>
                                    </td>
                                    <td>
                                        <a class="h4" href="{$_url}client/tickets/view/{$d['tid']}/">{$d['subject']}</a>
                                        <div class="text-muted  mt-2">
                                            <em>{$_L['Updated']} </em> <em class="mmnt">{strtotime($d['updated_at'])}</em> by <a class="text-info" href="{$_url}tickets/client/view/{$d['tid']}/">{$d['last_reply']}</a>
                                        </div>
                                    </td>


                                </tr>

                                {foreachelse}
                                <tr><td align="center" style="border-top: none">{$_L['You do not have any Tickets']}</td></tr>
                            {/foreach}

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>



{/block}