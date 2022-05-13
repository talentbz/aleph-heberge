<a href="{$_url}invoices/add/1/{$cid}/" class="btn btn-primary waves-effect waves-light">{$_L['New Invoice']}</a>
<a href="{$_url}invoices/add/recurring/{$cid}/" class="btn btn-primary waves-effect waves-light">{$_L['New Recurring Invoice']}</a>

<hr>
<br>


<h5> {$_L['Total Invoice Amount']}: <span class="amount" data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-a-pad="{$config['currency_decimal_digits']}" data-p-sign="{$config['currency_symbol_position']}" data-a-sign="{$config['currency_code']} " data-d-group="{$config['thousand_separator_placement']}">{$total_invoice_amount}</span></h5>
<h5 class="text-success"> {$_L['Total Paid Amount']}: <span class="amount" data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-a-pad="{$config['currency_decimal_digits']}" data-p-sign="{$config['currency_symbol_position']}" data-a-sign="{$config['currency_code']} " data-d-group="{$config['thousand_separator_placement']}">{$total_paid_amount}</span></h5>
<h5 class="text-danger"> {$_L['Total Un Paid Amount']}: <span class="amount" data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-a-pad="{$config['currency_decimal_digits']}" data-p-sign="{$config['currency_symbol_position']}" data-a-sign="{$config['currency_code']} " data-d-group="{$config['thousand_separator_placement']}">{$total_unpaid_amount}</span></h5>

<hr>
<div class="table-responsive">
    <table class="table table-striped sys_table">
        <thead style="background: #f0f2ff">
        <tr>
            <th>#</th>
            <th>{$_L['Account']}</th>
            <th>{$_L['Amount']}</th>
            <th>{$_L['Invoice Date']}</th>
            <th>{$_L['Due Date']}</th>
            <th>{$_L['Status']}</th>
            <th class="text-right">{$_L['Manage']}</th>
        </tr>
        </thead>
        <tbody>

        {foreach $invoices as $invoice}
            <tr>
                <td>{$invoice['invoicenum']}{if $invoice['cn'] neq ''} {$invoice['cn']} {else} {$invoice['id']} {/if}</td>
                <td>{$invoice['account']}</td>
                <td class="amount" data-a-sign="{if $invoice['currency_symbol'] eq ''} {$config['currency_code']} {else} {$invoice['currency_symbol']}{/if} ">{$invoice['total']}</td>
                <td>{date( $config['df'], strtotime($invoice['date']))}</td>
                <td>{date( $config['df'], strtotime($invoice['duedate']))}</td>
                <td>{ib_lan_get_line($invoice['status'])}</td>
                <td>
                    <div class="btn-group float-right">
                        <a href="{$_url}invoices/view/{$invoice['id']}/" class="btn btn-primary btn-sm"> {$_L['View']}</a>
                        <a href="{$_url}invoices/edit/{$invoice['id']}/" class="btn btn-info btn-sm"> {$_L['Edit']}</a>

                    </div>

                </td>
            </tr>
        {/foreach}

        </tbody>
    </table>
</div>


