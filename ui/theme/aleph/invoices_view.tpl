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
            color: #2CCE89!important;
        }
        .alert-success {
            color: #2cce89;
            background-color: #d7f1da;
            border-color: #d7f1da;
        }
        .alert-danger {
            color: #e7026e;
            background-color: #ffe5f1;
            border-color: #ffe5f1;
        }
        .alert-info {
            color: #5e72e4;
            background-color: #e3e4fd;
            border-color: #e3e4fd;
        }
    </style>
{/block}



{block name="content"}
    <div class="row">
        <div class="col-lg-12">
            <div class="form-group">
                <label for="exampleInputEmail1">{$_L['Unique Invoice URL']}:</label>
                <input type="text" class="form-control mb-3" id="invoice_public_url" onClick="this.setSelectionRange(0, this.value.length)" value="{$_url}client/iview/{$d['id']}/token_{$d['vtoken']}">
            </div>
        </div>
        <div class="col-lg-12"  id="application_ajaxrender">
            <div class="panel">
                <div class="panel-hdr">
                    <h2 class="d-none d-md-inline">{$_L['Invoice']} - {$d['invoicenum']}{if $d['cn'] neq ''} {$d['cn']} {else} {$d['id']} {/if} </h2>
                    <input type="hidden" name="iid" value="{$d['id']}" id="iid">

                    <div class="panel-toolbar">
                        <div class="btn-group flex-wrap" role="group">





                            <div class="btn-group " role="group">
                                <button type="button" class="btn  btn-success btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fal fa-envelope"></i> <span class="d-none d-md-inline">{$_L['Send Email']}</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="dropdown-item"><a href="#" id="mail_invoice_created">{$_L['Invoice Created']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="mail_invoice_reminder">{$_L['Invoice Payment Reminder']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="mail_invoice_overdue">{$_L['Invoice Overdue Notice']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="mail_invoice_confirm">{$_L['Invoice Payment Confirmation']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="mail_invoice_refund">{$_L['Invoice Refund Confirmation']}</a></li>
                                </ul>
                            </div>

                            <div class="btn-group" role="group">
                                <button type="button" class="btn  btn-dark btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fal fa-envelope-o"></i>  <span class="d-none d-md-inline">{$_L['SMS']}</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="dropdown-item"><a href="#" id="sms_invoice_created">{$_L['Invoice Created']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="sms_invoice_reminder">{$_L['Invoice Payment Reminder']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="sms_invoice_overdue">{$_L['Invoice Overdue Notice']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="sms_invoice_confirm">{$_L['Invoice Payment Confirmation']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="sms_invoice_refund">{$_L['Invoice Refund Confirmation']}</a></li>
                                </ul>
                            </div>

                            <div class="btn-group" role="group">
                                <button type="button" class="btn  btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fal fa-ellipsis-v"></i>  <span class="d-none d-md-inline">{$_L['Mark As']}</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    {if $d['status'] neq 'Paid'}
                                        <li class="dropdown-item"><a href="#" id="mark_paid">{$_L['Paid']}</a></li>
                                    {/if}
                                    {if $d['status'] neq 'Unpaid'}
                                        <li class="dropdown-item"><a href="#" id="mark_unpaid">{$_L['Unpaid']}</a></li>
                                    {/if}
                                    {if $d['status'] neq 'Partially Paid'}
                                        <li class="dropdown-item"><a href="#" id="mark_partially_paid">{$_L['Partially Paid']}</a></li>
                                    {/if}
                                    {if $d['status'] neq 'Cancelled'}
                                        <li class="dropdown-item"><a href="#" id="mark_cancelled">{$_L['Cancelled']}</a></li>
                                    {/if}

                                </ul>
                            </div>

                            {if $config['accounting'] eq '1'}
                                <button type="button" class="btn  btn-danger btn-sm" id="add_payment"><i class="fal fa-plus"></i> <span class="d-none d-md-inline">{$_L['Add Payment']}</span></button>
                            {/if}

                            <a href="{$_url}client/iview/{$d['id']}/token_{$d['vtoken']}" target="_blank" class="btn btn-primary  btn-sm"><i class="fal fa-file-alt"></i> <span class="d-none d-md-inline">{$_L['Preview']}</span></a>
                            <a href="{$_url}invoices/edit/{$d['id']}" class="btn btn-warning  btn-sm"><i class="fal fa-pencil"></i> <span class="d-none d-md-inline">{$_L['Edit']}</span></a>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn  btn-success btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fal fa-file-pdf-o"></i>
                                    <span class="d-none d-md-inline">{$_L['PDF']}</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="dropdown-item"><a href="{$_url}client/ipdf/{$d['id']}/token_{$d['vtoken']}/view/" target="_blank">{$_L['View PDF']}</a></li>
                                    <li class="dropdown-item"><a href="{$_url}client/ipdf/{$d['id']}/token_{$d['vtoken']}/dl/">{$_L['Download PDF']}</a></li>
                                </ul>
                            </div>

                            <a data-toggle="modal" href="#modal_add_item" class="btn btn-sm btn-success"><i class="fal fa-paperclip"></i> </a>
                            <a href="{$_url}invoices/clone/{$d['id']}/" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" title="{$_L['Clone']}"><i class="fal fa-copy"></i> </a>

{*                                                        <a href="{$_url}iview/print/{$d['id']}/token_{$d['vtoken']}" target="_blank" class="btn btn-primary  btn-sm">  <span class="d-none d-md-inline">{$_L['Delivery Order']}</span></a>*}
                            <a href="{$_url}iview/print/{$d['id']}/token_{$d['vtoken']}" target="_blank" class="btn btn-dark  btn-sm"><i class="fal fa-print"></i>  <span class="d-none d-md-inline">{$_L['Print']}</span></a>


                        </div>
                    </div>

                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <div class="invoice">
                            <header class="clearfix">
                                <div class="row">
                                    <div class="col-sm-6 mt-md">
                                        <h2 class="h2 mt-none mb-sm text-dark text-bold">{$_L['INVOICE']}</h2>
                                        <h4 class="h4 m-none text-dark text-bold">#{$d['invoicenum']}{if $d['cn'] neq ''} {$d['cn']} {else} {$d['id']} {/if}</h4>

                                        {if $d['status'] eq 'Unpaid'}
                                            <h3 class="alert alert-danger">{$_L['Unpaid']}</h3>
                                        {elseif $d['status'] eq 'Paid'}
                                            <h3 class="alert alert-success">{$_L['Paid']}</h3>
                                        {elseif $d['status'] eq 'Partially Paid'}
                                            <h3 class="alert alert-info">{$_L['Partially Paid']}</h3>
                                        {else}
                                            <h3 class="alert alert-info">{$d['status']}</h3>
                                        {/if}

                                        {if isset($d['title']) && $d['title'] != ''}
                                            <h4>{$d['title']}</h4>
                                            <hr>
                                        {/if}

                                        {if $config['invoice_receipt_number'] eq '1' && $d['receipt_number'] neq ''}
                                            <h4>{$_L['Receipt Number']}: {$d['receipt_number']}</h4>
                                            <hr>
                                        {/if}


                                    </div>
                                    <div class="col-sm-6 text-right mt-md mb-md">

                                        <div class="ib">
                                            <img src="{$app_url}storage/system/{$config['logo_default']}" alt="Logo" style="margin-bottom: 15px;">
                                        </div>

                                        <address class="ib mr-xlg">
                                            <strong>{$config['CompanyName']}</strong>
                                            <br>
                                            {$config['caddress']}

                                            {if isset($config['vat_number']) && ($config['vat_number'] != '')}

                                                {if $config['tax_system'] == 'India'}

                                                    <br>
                                                    <strong>GSTIN:</strong> {$config['vat_number']}

                                                {else}

                                                    <br>
                                                    <strong>{$_L['Vat number']}:</strong> {$config['vat_number']}

                                                {/if}

                                            {/if}


                                        </address>

                                    </div>
                                </div>
                            </header>
                            <div class="bill-info">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="bill-to">
                                            <p class="h5 mb-xs text-dark text-semibold"><strong>{$_L['Invoiced To']}:</strong></p>
                                            <address>
                                                {if $a['company'] neq ''}
                                                    {$a['company']}
                                                    <br>

                                                    {if $company && $config['show_business_number'] eq '1' }

                                                        {if $company->business_number neq ''}
                                                            {$config['label_business_number']}: {$company->business_number}
                                                            <br>
                                                        {/if}
                                                    {/if}

                                                    {$_L['ATTN']}: {$d['account']}
                                                    <br>
                                                {else}
                                                    {$d['account']}
                                                    <br>
                                                {/if}

                                                {*                                            {$a['address']} <br>*}
                                                {*                                            {$a['city']} <br>*}
                                                {*                                            {$a['state']} - {$a['zip']} <br>*}
                                                {*                                            {$a['country']}*}

                                                {getContactFormattedAddress($config,$a)}

                                                <br>
                                                <strong>{$_L['Phone']}:</strong> {$a['phone']}

                                                {if $config['fax_field'] neq '0' && $a['fax'] neq ''}
                                                    <br>
                                                    <strong>{$_L['Fax']}:</strong> {$a['fax']}
                                                {/if}

                                                <br>
                                                <strong>{$_L['Email']}:</strong> {$a['email']}

                                                {if $config['tax_system'] == 'India'}

                                                    <br>
                                                    <strong>GSTIN:</strong> {$a['business_number']}

                                                {/if}


                                                {foreach $cf as $cfs}
                                                    {if $cfs['showinvoice'] == 'No'}
                                                        {continue}
                                                    {/if}
                                                    <br>
                                                    <strong>{$cfs['fieldname']}: </strong> {get_custom_field_value($cfs['id'],$a['id'])}
                                                {/foreach}

                                                {$x_html}
                                            </address>





                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="bill-data text-right">
                                            <p class="mb-none">
                                                <span class="text-dark">{$_L['Invoice Date']}:</span>
                                                <span class="value">{date( $config['df'], strtotime($d['date']))}</span>
                                            </p>
                                            <p class="mb-none">
                                                <span class="text-dark">{$_L['Due Date']}:</span>
                                                <span class="value">{date( $config['df'], strtotime($d['duedate']))}</span>
                                            </p>
                                            <h2> {$_L['Invoice Total']}: {formatCurrency($d['total'],$d['currency_iso_code'])} </h2>
                                            {if ($d['credit']) neq '0.00'}
                                                <h2> {$_L['Total Paid']}: {formatCurrency($d['credit'],$d['currency_iso_code'])} </h2>

                                                <h2> {$_L['Amount Due']}: {formatCurrency($i_due,$d['currency_iso_code'])} </h2>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>




                            {$extraHtml}





                            {if $quote}

                                <h4>{$_L['Quote']}: {$quote->id}</h4>

                                <div class="row">
                                    <div class="col-md-12">
                                        <hr>
                                        {$quote->proposal}
                                        <hr>
                                    </div>
                                </div>
                            {/if}

                            <div class="table-responsive">


                                {if $config['tax_system'] == 'India'}

                                    <table class="table table-bordered invoice-items">
                                        <thead>
                                        <tr class="text-dark">
                                            <th id="cell-id" class="text-semibold">S/L</th>
                                            <th id="cell-item" class="text-semibold">{$_L['Item']}</th>
                                            <th class="text-semibold">HSN / SAC</th>
                                            <th id="cell-price" class="text-center text-semibold">{$_L['Price']}</th>
                                            <th id="cell-qty" class="text-center text-semibold">{if $d['show_quantity_as'] eq '' || $d['show_quantity_as'] eq '1'}{$_L['Qty']}{else}{$d['show_quantity_as']}{/if}</th>
                                            <th class="text-right">Taxable Value</th>


                                            {if $d['is_same_state']}

                                                <th class="text-right">CGST</th>
                                                <th class="text-right">SGST/UTGST</th>
                                                <th class="text-right">GST</th>

                                            {else}

                                                <th class="text-right">IGST</th>

                                            {/if}




                                            <th id="cell-total" class="text-right text-semibold">{$_L['Total']}</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        {foreach $items as $item}
                                            <tr>
                                                <td>
                                                    {if $item['itemcode'] != ''}
                                                        {$item['itemcode']}
                                                    {else}
                                                        {counter}
                                                    {/if}
                                                </td>
                                                <td class="text-semibold text-dark">{$item['description']}</td>
                                                <td class="text-semibold text-dark">{$item['tax_code']}</td>
                                                <td class="text-center">{formatCurrency($item['amount'],$d['currency_iso_code'],$format_currency_override)}</td>
                                                <td class="text-center">{$item['qty']}</td>
                                                <td class="text-right">
                                                    {if $item['discount_amount'] != '0.00'}

                                                        Total: {formatCurrency(($item['amount']*$item['qty']),$d['currency_iso_code'])}


                                                        <br>
                                                        Discount: {$item['discount_amount']}
                                                        <br>
                                                        Taxable amount: {formatCurrency((($item['amount']*$item['qty'])-$item['discount_amount']),$d['currency_iso_code'])}

                                                    {else}

                                                        {formatCurrency(($item['amount']*$item['qty']),$d['currency_iso_code'])}

                                                    {/if}


                                                </td>


                                                {if $d['is_same_state']}

                                                    <td class="text-right">
                                                        {formatCurrency((gstIndiaSplitTaxValue($item['total'],$item['tax_rate'])),$d['currency_iso_code'])}

                                                        <br>
                                                        @{round($item['tax_rate']/2,2)}%
                                                    </td>
                                                    <td class="text-right">

                                                            {formatCurrency((gstIndiaSplitTaxValue($item['total'],$item['tax_rate'])),$d['currency_iso_code'])}

                                                        <br>
                                                        @{round($item['tax_rate']/2,2)}%
                                                    </td>
                                                    <td class="text-right">
                                                        {formatCurrency(round($item['taxamount'],2),$d['currency_iso_code'])} <br>
                                                        @{round($item['tax_rate'],2)}%

                                                    </td>

                                                {else}



                                                    <td class="text-right">
                                                        {formatCurrency(round(( ($item['tax_rate']*($item['qty'] * $item['amount'])) / 100),2),$d['currency_iso_code'])} <br>
                                                        @{round($item['tax_rate'],2)}%

                                                    </td>

                                                {/if}




                                                <td class="text-right">{formatCurrency(($item['total'] + $item['taxamount']),$d['currency_iso_code'])}</td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>

                                {else}

                                    <table class="table table-bordered invoice-items">
                                        <thead>
                                        <tr class="text-dark">
                                            <th id="cell-id" class="text-semibold">#</th>
                                            <th id="cell-item" class="text-semibold">{$_L['Item']}</th>
                                            <th id="cell-price" class="text-center text-semibold">{$_L['Price']}</th>
                                            <th id="cell-qty" class="text-center text-semibold">{if $d['show_quantity_as'] eq '' || $d['show_quantity_as'] eq '1'}{$_L['Qty']}{else}{$d['show_quantity_as']}{/if}</th>
                                            <th id="cell-total" class="text-center text-semibold">{$_L['Total']}</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        {foreach $items as $item}
                                            <tr>
                                                <td>{$item['itemcode']}</td>
                                                <td class="text-semibold text-dark">{$item['description']}</td>
                                                <td class="text-center">{formatCurrency($item['amount'],$d['currency_iso_code'],$format_currency_override)}</td>
                                                <td class="text-center">{$item['qty']}</td>
                                                <td class="text-center">{formatCurrency(($item['total'] + $item['taxamount']),$d['currency_iso_code'])}</td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>

                                {/if}



                            </div>

                            <div class="invoice-summary">
                                <div class="row">
                                    <div class="col-md-4 offset-md-8">
                                        <table class="table h5 text-dark">
                                            <tbody>
                                            <tr class="b-top-none">
                                                <td colspan="2">{$_L['Subtotal']}</td>
                                                <td class="text-left">{{formatCurrency($d['subtotal'],$d['currency_iso_code'])}}</td>
                                            </tr>
                                            {if ($d['discount']) neq '0.00'}
                                                <tr>
                                                    <td colspan="2">{$_L['Discount']}</td>
                                                    <td class="text-left">{formatCurrency($d['discount'],$d['currency_iso_code'])}</td>
                                                </tr>
                                            {/if}

                                            {if $config['tax_system'] == 'India'}
                                                <tr>
                                                    <td colspan="2">GST Total</td>
                                                    <td class="text-left">{formatCurrency($d['tax'],$d['currency_iso_code'])}</td>
                                                </tr>
                                            {else}

                                                <tr>
                                                    <td colspan="2">{$_L['TAX']}</td>
                                                    <td class="text-left">{formatCurrency($d['tax'],$d['currency_iso_code'])}</td>
                                                </tr>

                                            {/if}

                                            {if ($d['credit']) neq '0.00'}
                                                <tr>
                                                    <td colspan="2">{$_L['Total']}</td>
                                                    <td class="text-left">{formatCurrency($d['total'],$d['currency_iso_code'])}</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">{$_L['Total Paid']}</td>
                                                    <td class="text-left">{formatCurrency($d['credit'],$d['currency_iso_code'])}</td>
                                                </tr>
                                                <tr class="h4">
                                                    <td colspan="2">{$_L['Amount Due']}</td>
                                                    {*<td class="text-left">{$config['currency_code']} {number_format($i_due,2,$config['dec_point'],$config['thousands_sep'])}</td>*}
                                                    <td class="text-left">{formatCurrency($i_due,$d['currency_iso_code'])}</td>
                                                </tr>
                                            {else}
                                                <tr class="h4">
                                                    <td colspan="2">{$_L['Grand Total']}</td>
                                                    <td class="text-left">{formatCurrency($d['total'],$d['currency_iso_code'])}</td>
                                                </tr>
                                            {/if}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {if ($trs_c neq '')}
                            <h3>{$_L['Related Transactions']}</h3>
                            <table class="table table-bordered sys_table">
                                <th>{$_L['Date']}</th>
                                <th>{$_L['Account']}</th>


                                <th class="text-right">{$_L['Amount']}</th>

                                <th>{$_L['Description']}</th>




                                {foreach $trs as $tr}
                                    <tr class="{if $tr['cr'] eq '0.00'}warning {else}info{/if}">
                                        <td>{date( $config['df'], strtotime($tr['date']))}</td>
                                        <td>{$tr['account']}</td>


                                        <td class="text-right">{formatCurrency($tr['amount'],$d['currency_iso_code'])}</td>
                                        <td>{$tr['description']}</td>


                                    </tr>
                                {/foreach}



                            </table>
                        {/if}

                        {if $inv_files_c neq ''}

                            <table class="table table-bordered table-hover sys_table">
                                <thead>
                                <tr>
                                    <th class="text-right" data-sort-ignore="true" width="20px;">{$_L['Type']}</th>

                                    <th>{$_L['File']}</th>

                                    <th class="text-right" data-sort-ignore="true" width="100px;">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $inv_files as $ds}

                                    <tr>

                                        <td>
                                            {if $ds['file_mime_type'] eq 'jpg' || $ds['file_mime_type'] eq 'png' || $ds['file_mime_type'] eq 'gif'}
                                                <i class="fal fa-file-image-o"></i>
                                            {elseif $ds['file_mime_type'] eq 'pdf'}
                                                <i class="fal fa-file-pdf-o"></i>
                                            {elseif $ds['file_mime_type'] eq 'zip'}
                                                <i class="fal fa-file-archive-o"></i>
                                            {else}
                                                <i class="fal fa-file"></i>
                                            {/if}
                                        </td>


                                        <td>

                                            {$ds['title']}

                                            {if $ds['file_mime_type'] eq 'jpg' || $ds['file_mime_type'] eq 'png' || $ds['file_mime_type'] eq 'gif'}

                                                <div class="hr-line-dashed"></div>

                                                <img src="{$app_url}storage/docs/{$ds['file_path']}" class="img-responsive" alt="{$ds['title']}">

                                            {/if}

                                        </td>

                                        <td class="text-right">

                                            <a data-toggle="tooltip" data-placement="top" title="{$_L['Download']}" href="{$_url}client/dl/{$ds['id']}_{$ds['file_dl_token']}/" class="btn btn-primary"><i class="fal fa-download"></i> </a>

                                            <a data-toggle="tooltip" data-placement="top" title="{$_L['Delete']}" onclick="confirmThenGoToUrl(event,'delete/document/{$ds['id']}');" href="javascript:;" class="btn btn-danger"><i class="fal fa-trash"></i> </a>

                                        </td>


                                    </tr>

                                {/foreach}

                                </tbody>



                            </table>

                        {/if}

                        {if ($d['notes']) neq ''}
                            <div class="well m-t">
                                {$d['notes']}
                            </div>
                        {/if}

                        {if ($emls_c neq '')}
                            <hr>
                            <h3>{$_L['Related Emails']}</h3>
                            <table class="table table-bordered sys_table">
                                <th width="20%">{$_L['Date']}</th>
                                <th>{$_L['Subject']}</th>







                                {foreach $emls as $eml}
                                    <tr>
                                        <td>{date( $config['df'], strtotime($eml['date']))}</td>
                                        <td>{$eml['subject']}</td>
                                    </tr>
                                {/foreach}



                            </table>
                        {/if}


                        {if count($access_logs) neq 0}
                            <hr>
                            <h3>{$_L['Customer']} : {$_L['Access Log']}</h3>
                            <table class="table table-bordered sys_table">
                                <th>{$_L['Time']}</th>
                                <th>{$_L['IP']}</th>
                                <th>{$_L['Country']}</th>
                                <th>{$_L['City']}</th>
                                <th>{$_L['Browser']}</th>

                                {foreach $access_logs as $log}
                                    <tr>
                                        <td>{date( $config['df']|cat:' H:i:s', strtotime($log['viewed_at']))}</td>
                                        <td>{$log['ip']}</td>
                                        <td>{$log['country']}</td>
                                        <td>{$log['city']}</td>
                                        <td>{$log['browser']}</td>
                                    </tr>
                                {/foreach}



                            </table>
                        {/if}



                    </div>
                </div>


            </div>
        </div>
    </div>



    <div id="modal_add_item" class="modal fade" tabindex="-1"  role="dialog" aria-hidden="true">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                        {$_L['New Document']}
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="doc_title">{$_L['Title']}</label>
                            <input type="text" class="form-control" id="doc_title" name="doc_title">

                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" id="is_global" name="is_global"> {$_L['Available for all Customers']}
                            </label>
                        </div>





                    </form>

                    <hr>

                    <form action="" class="dropzone" id="upload_container">

                        <div class="dz-message">
                            <h3> <i class="fal fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Click to Upload']}</span>
                        </div>

                    </form>
                    <hr>
                    <h4>{$_L['Server Config']}:</h4>
                    <p>{$_L['Upload Maximum Size']}: {$upload_max_size}</p>
                    <p>{$_L['POST Maximum Size']}: {$post_max_size}</p>

                </div>
                <div class="modal-footer">
                    <input type="hidden" name="file_link" id="file_link" value="">
                    <button type="button" data-dismiss="modal" class="btn btn-danger">{$_L['Close']}</button>
                    <button type="button" id="btn_add_file" class="btn btn-primary">{$_L['Submit']}</button>
                </div>
            </div>
        </div>


    </div>



    <input type="hidden" id="_lan_msg_confirm" value="{$_L['are_you_sure']}">
    <input type="hidden" id="admin_email" value="{$user->username}">


{/block}

{block name="script"}


    <script>


        Dropzone.autoDiscover = false;
        $(document).ready(function () {



            var _url = $("#_url").val();

            var $modal = $('#cloudonex_body');


            var sysrender = $('#application_ajaxrender');

            $('.amount').autoNumeric('init', {

                aSign: '{$config['currency_code']}',
                dGroup: {$config['thousand_separator_placement']},
                aPad: {$config['currency_decimal_digits']},
                pSign: '{$config['currency_symbol_position']}',
                aDec: '{$config['dec_point']}',
                aSep: '{$config['thousands_sep']}',
                vMax: '9999999999999999.00',
                vMin: '-9999999999999999.00'

            });

            var iid = $("#iid").val();
            sysrender.on('click', '#add_payment', function(e){
                e.preventDefault();

                $.fancybox.open({
                    src  :  base_url + 'invoices/add-payment/' + iid,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $(".datepicker").datepicker();
                            $("#account").select2({

                            });
                            $("#cats").select2({

                            });
                            $("#pmethod").select2({

                            });
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });


            });


            sysrender.on('click', '#mail_invoice_created', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/mail_invoice_/' + iid + '/created',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });



            });

            sysrender.on('click', '#mail_invoice_reminder', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/mail_invoice_/' + iid + '/reminder',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });


            });

            sysrender.on('click', '#mail_invoice_overdue', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/mail_invoice_/' + iid + '/overdue',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });







            });

            sysrender.on('click', '#mail_invoice_confirm', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/mail_invoice_/' + iid + '/confirm',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });





            });

            sysrender.on('click', '#mail_invoice_refund', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/mail_invoice_/' + iid + '/refund',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });


            });



            sysrender.on('click', '#sms_invoice_created', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/sms_invoice_/' + iid + '/created',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').countSms('#sms-counter');
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });




            });

            sysrender.on('click', '#sms_invoice_reminder', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/sms_invoice_/' + iid + '/reminder',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').countSms('#sms-counter');
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });



            });

            sysrender.on('click', '#sms_invoice_overdue', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/sms_invoice_/' + iid + '/overdue',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').countSms('#sms-counter');
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });


            });

            sysrender.on('click', '#sms_invoice_confirm', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/sms_invoice_/' + iid + '/confirm',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').countSms('#sms-counter');
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });



            });

            sysrender.on('click', '#sms_invoice_refund', function(e){
                e.preventDefault();
                var iid = $("#iid").val();

                $.fancybox.open({
                    src  :  base_url + 'invoices/sms_invoice_/' + iid + '/refund',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#message').countSms('#sms-counter');
                        },
                        touch: false,
                        autoFocus: false,
                        keyboard: false,
                    },
                });



            });




            $modal.on('click', '#btnModalSMSSend', function(event){

                event.preventDefault();

                $.post(base_url + 'sms/init/send_invoice', {


                    message: $('#message').val(),
                    to: $("#sms_to").val(),
                    from: $("#sms_from").val(),
                    invoice_id: $("#smsInvoiceId").val()

                }).done(function (data) {

                    toastr.success(data);
                });

            });



            $modal.on('click', '#send', function(e){

                e.preventDefault();

                var attach_pdf = 'No';

                if($("#attach_pdf").prop('checked') == true){
                    attach_pdf = 'Yes';
                }



                $.post(base_url + 'invoices/send_email', $('#email_form').serialize()).done(function (data) {
                    toastr.success(data);
                });

            });

            $modal.on('click', '#save_payment', function(e){
                e.preventDefault();

                $.post(base_url + 'invoices/add-payment-post', $("#form_add_payment").serialize())

                    .done(function (data) {

                        if ($.isNumeric(data)) {
                            location.reload();
                        }
                        else {
                            toastr.error(data);
                        }
                    });

            });

            $("#mark_paid").click(function (e) {
                e.preventDefault();


                bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                    if(result){
                        var iid = $("#iid").val();
                        $.post(  _url + "invoices/markpaid", { iid: iid })
                            .done(function( data ) {
                                location.reload();
                            });
                    }
                });

            });


            $("#mark_unpaid").click(function (e) {
                e.preventDefault();


                bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                    if(result){
                        var iid = $("#iid").val();
                        $.post(  _url + "invoices/markunpaid", { iid: iid })
                            .done(function( data ) {
                                location.reload();
                            });
                    }
                });

            });

            $("#mark_cancelled").click(function (e) {
                e.preventDefault();
                bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                    if(result){
                        var iid = $("#iid").val();
                        $.post(  _url + "invoices/markcancelled", { iid: iid })
                            .done(function( data ) {
                                location.reload();
                            });
                    }
                });

            });

            $("#mark_partially_paid").click(function (e) {
                e.preventDefault();
                bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                    if(result){
                        var iid = $("#iid").val();
                        $.post(  _url + "invoices/markpartiallypaid", { iid: iid })
                            .done(function( data ) {
                                location.reload();
                            });
                    }
                });

            });



            $modal.on('click', '#send_bcc_to_admin', function(e){

                e.preventDefault();


                $("#bccemail").val($("#admin_email").val());

            });

            $modal.on('hidden.bs.modal', function () {
                location.reload();
            });



            // attach file






            $('[data-toggle="tooltip"]').tooltip();

            var $btn_add_file = $("#btn_add_file");

            var $file_link = $("#file_link");

            var upload_resp;




            var ib_file = new Dropzone("#upload_container",
                {
                    url: _url + "documents/upload/",
                    maxFiles: 1
                }
            );


            ib_file.on("sending", function() {

                $btn_add_file.prop('disabled', true);

            });

            ib_file.on("success", function(file,response) {

                $btn_add_file.prop('disabled', false);

                upload_resp = response;

                if(upload_resp.success == 'Yes'){

                    toastr.success(upload_resp.msg);
                    $file_link.val(upload_resp.file);


                }
                else{
                    toastr.error(upload_resp.msg);
                }


            });




            var $doc_title = $("#doc_title");


            $btn_add_file.on('click', function(e) {
                e.preventDefault();


                $.post( _url + "documents/post/", { title: $doc_title.val(), file_link: $file_link.val(), rid: iid, rtype: 'invoice' })
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {
                            toastr.error(data);
                        }




                    });


            });



        });



    </script>
{/block}
