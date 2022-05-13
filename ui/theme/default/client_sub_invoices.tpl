<div class="row">
    <div class="col-sm-6 col-xl-4">
        <div class="p-3 bg-primary-900 rounded overflow-hidden position-relative text-white mb-g">
            <div class="">
                <h3 class="display-4 d-block l-h-n m-0 fw-500">
                    {formatCurrency($total_invoice_issued_amount,$config['home_currency'])}
                    <small class="m-0 l-h-n">{$_L['Total Invoice Issued Amount']}</small>
                </h3>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-4">
        <div class="p-3 bg-success-900 rounded overflow-hidden position-relative text-white mb-g">
            <div class="">
                <h3 class="display-4 d-block l-h-n m-0 fw-500">
                    {formatCurrency($total_paid_amount,$config['home_currency'])}
                    <small class="m-0 l-h-n">{$_L['Total Paid']}</small>
                </h3>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-4">
        <div class="p-3 bg-danger-900 rounded overflow-hidden position-relative text-white mb-g">
            <div class="">
                <h3 class="display-4 d-block l-h-n m-0 fw-500">
                    {formatCurrency($total_unpaid_amount,$config['home_currency'])}
                    <small class="m-0 l-h-n">{$_L['Total Unpaid']}</small>
                </h3>
            </div>
        </div>
    </div>
</div>

<table class="table table-bordered table-hover" id="clx_datatable">
    <thead>
    <tr>
        <th>#</th>
        <th>{$_L['Account']}</th>
        <th>{$_L['Amount']}</th>
        <th>{$_L['Invoice Date']}</th>
        <th>{$_L['Due Date']}</th>
        <th>
            {$_L['Status']}
        </th>
    </tr>
    </thead>
    <tbody>

    {foreach $invoices as $invoice}
        <tr>
            <td><a target="_blank"
                   href="{$_url}client/iview/{$invoice->id}/token_{$invoice->vtoken}/">{$invoice->invoicenum}{if $invoice->cn neq ''} {$invoice->cn} {else} {$invoice->id} {/if}</a>
            </td>
            <td>{$invoice->account} </td>
            <td>{formatCurrency($invoice->total,$invoice->currency_iso_code)}</td>
            <td>{date( $config['df'], strtotime($invoice->date))}</td>
            <td>{date( $config['df'], strtotime($invoice->duedate))}</td>
            <td>

                {if $invoice->status eq 'Unpaid'}
                    <span class="badge badge-danger">{ib_lan_get_line($invoice->status)}</span>
                {elseif $invoice->status eq 'Paid'}
                    <span class="badge badge-success">{ib_lan_get_line($invoice->status)}</span>
                {elseif $invoice->status eq 'Partially Paid'}
                    <span class="badge badge-info">{ib_lan_get_line($invoice->status)}</span>
                {elseif $invoice->status eq 'Cancelled'}
                    <span class="label">{ib_lan_get_line($invoice->status)}</span>
                {else}
                    {ib_lan_get_line($invoice->status)}
                {/if}


            </td>


        </tr>
    {/foreach}

    </tbody>


</table>
