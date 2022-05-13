{extends file="layouts/base.tpl"}

{block name="content_body"}
    <div class="mx-auto" style="max-width: 980px; width: 100%; margin-top: 50px;">
        <section class="panel">

            <div class="panel-container">
                <div class="panel-content">

                    <div class="invoice">
                        <header class="clearfix">
                            <div class="text-right">

                                <br>



                                <div class="btn-group">
                                    <a href="{$_url}client/qpdf/{$d['id']}/token_{$d['vtoken']}" class="btn btn-primary"><i class="fal fa-print"></i> {$_L['View PDF']}</a>
                                    <a href="{$_url}client/qpdf/{$d['id']}/token_{$d['vtoken']}/dl/" class="btn btn-info"><i class="fal fa-file-pdf-o"></i> {$_L['Download PDF']}</a>



                                    {if ($d['stage'] neq 'Accepted')}
                                        <a href="{$_url}client/q_accept/{$d['id']}/token_{$d['vtoken']}" class="btn btn-success">{$_L['Accept']}</a>
                                    {/if}

                                    {if ($d['stage'] neq 'Lost')}
                                        <a href="{$_url}client/q_decline/{$d['id']}/token_{$d['vtoken']}" class="btn btn-danger">{$_L['Decline']}</a>
                                    {/if}
                                </div>





                            </div>
                            <div class="row">
                                <div class="col-md-12 mt-md">
                                    <h2 class="h2 mt-none mb-sm text-dark text-bold">{$config['CompanyName']}</h2>
                                    <h4 class="h4 m-none text-dark text-bold">{$_L['Quote']} #{$d['invoicenum']}{if $d['cn'] neq ''} {$d['cn']} {else} {$d['id']} {/if}</h4>

                                </div>

                            </div>
                        </header>
                        <div class="bill-info">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="bill-to">
                                        <p class="h5 mb-xs text-dark text-semibold"><strong>{$_L['Recipient']}:</strong></p>
                                        <address>
                                            {if $a['company'] neq ''}
                                                {$a['company']}
                                                <br>
                                                {$_L['ATTN']}: {$d['account']}
                                                <br>
                                            {else}
                                                {$d['account']}
                                                <br>
                                            {/if}

                                            {$a['address']} <br>
                                            {$a['city']} <br>
                                            {$a['state']} - {$a['zip']} <br>
                                            {$a['country']}
                                            <br>
                                            <strong>{$_L['Phone']}:</strong> {$a['phone']}
                                            <br>
                                            <strong>{$_L['Email']}:</strong> {$a['email']}
                                            {foreach $cf as $cfs}
                                                <br>
                                                <strong>{$cfs['fieldname']}: </strong> {get_custom_field_value($cfs['id'],$a['id'])}
                                            {/foreach}

                                            {$x_html}
                                        </address>





                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="bill-data text-right">

                                        <div class="ib">
                                            <img src="{$app_url}storage/system/{$config['logo_default']}" alt="Logo" style="margin-bottom: 15px;">

                                        </div>

                                        <address class="ib mr-xlg">
                                            {$config['caddress']}
                                        </address>

                                        <p class="mb-none mt-lg">
                                            <span class="text-dark">{$_L['Date Created']}:</span>
                                            <span class="value">{date( $config['df'], strtotime($d['datecreated']))}</span>
                                        </p>
                                        <p class="mb-none">
                                            <span class="text-dark">{$_L['Expiry Date']}:</span>
                                            <span class="value">{date( $config['df'], strtotime($d['validuntil']))}</span>
                                        </p>
                                        <h2> {$_L['Total']}: {$config['currency_code']} {number_format($d['total'],2,$config['dec_point'],$config['thousands_sep'])} </h2>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <hr>

                                <strong>{$d['subject']}</strong>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <hr>
                                {$d['proposal']}
                                <hr>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-bordered invoice-items">
                                <thead>
                                <tr class="h4 text-dark">
                                    <th id="cell-id" class="text-semibold">#</th>
                                    <th id="cell-item" class="text-semibold">{$_L['Item']}</th>

                                    <th id="cell-price" class="text-center text-semibold">{$_L['Price']}</th>
                                    <th id="cell-qty" class="text-center text-semibold">{$_L['Quantity']}</th>
                                    <th id="cell-total" class="text-center text-semibold">{$_L['Total']}</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $items as $item}
                                    <tr>
                                        <td>{$item['itemcode']}</td>
                                        <td class="text-semibold text-dark">{$item['description']}</td>

                                        <td class="text-center nowrap">{$config['currency_code']} {number_format($item['amount'],2,$config['dec_point'],$config['thousands_sep'])}</td>
                                        <td class="text-center nowrap">{$item['qty']}</td>
                                        <td class="text-center nowrap">{$config['currency_code']} {number_format($item['total'],2,$config['dec_point'],$config['thousands_sep'])}</td>
                                    </tr>
                                {/foreach}

                                </tbody>
                            </table>
                        </div>

                        <div class="invoice-summary">
                            <div class="row">
                                <div class="col-sm-4 offset-md-8">
                                    <table class="table h5 text-dark">
                                        <tbody>
                                        <tr class="b-top-none">
                                            <td colspan="2">{$_L['Subtotal']}</td>
                                            <td class="text-left">{$config['currency_code']} {number_format($d['subtotal'],2,$config['dec_point'],$config['thousands_sep'])}</td>
                                        </tr>
                                        {if ($d['discount']) neq '0.00'}
                                            <tr>
                                                <td colspan="2">{$_L['Discount']}</td>
                                                <td class="text-left">{$config['currency_code']} {number_format($d['discount'],2,$config['dec_point'],$config['thousands_sep'])}</td>
                                            </tr>
                                        {/if}
                                        <tr>
                                            <td colspan="2">{$d['taxname']}</td>
                                            <td class="text-left">{$config['currency_code']} {number_format($d['tax1'],2,$config['dec_point'],$config['thousands_sep'])}</td>
                                        </tr>

                                        <tr class="h4">
                                            <td colspan="2">{$_L['Grand Total']}</td>
                                            <td class="text-left">{$config['currency_code']} {number_format($d['total'],2,$config['dec_point'],$config['thousands_sep'])}</td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <hr>
                                {$d['customernotes']}
                            </div>
                        </div>
                    </div>



                </div>
            </div>

        </section>
    </div>
{/block}
