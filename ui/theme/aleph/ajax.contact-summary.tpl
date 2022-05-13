




<div class="row">
    <div class="col-md-6 text-black">

        <div>
            <br>



            <strong class="h6">{$_L['Full Name']}: </strong> {$d['account']} <br>
            {if ($d['company']) neq ''}
                <strong class="h5">{$_L['Company Name']}: </strong> {$d['company']} <br>
            {/if}

            <strong class="h5">{$_L['Email']}: </strong> {if ($d['email']) neq ''} {$d['email']} {else} N/A {/if} <br>

            {if $d['secondary_email'] neq ''}

                <strong class="h5">{$_L['Secondary Email']}: </strong> {$d['secondary_email']} <br>

            {/if}

            <strong class="h5">{$_L['Phone']}: </strong> {if ($d['phone']) neq ''} {$d['phone']} {else} N/A {/if} <br>

            {if $config['fax_field'] eq '1'}
                <strong class="h5">{$_L['Fax']}: </strong> {if ($d['fax']) neq ''} {$d['fax']} {else} N/A {/if} <br>
            {/if}

            <strong class="h5">{$_L['Address']}: </strong> {if ($d['address']) neq ''} {$d['address']} {else} N/A {/if} <br>
            <strong class="h5">{$_L['City']}: </strong> {if ($d['city']) neq ''} {$d['city']} {else} N/A {/if} <br>
            <strong class="h5">{$_L['State Region']}: </strong> {if ($d['state']) neq ''} {$d['state']} {else} N/A {/if} <br>
            <strong class="h5">{$_L['ZIP Postal Code']}: </strong> {if ($d['zip']) neq ''} {$d['zip']} {else} N/A {/if} <br>
            <strong class="h5">{$_L['Country']}: </strong> {if ($d['country']) neq ''} {$d['country']} {else} N/A {/if} <br>
            <strong class="h5">{$_L['Tags']}: </strong> {if ($d['tags']) neq ''} {$d['tags']} {else} N/A {/if} <br>
            <strong class="h5">{$_L['Group']}: </strong> {if ($d['gname']) neq ''} {$d['gname']} {else} N/A {/if} <br>


            <p class="mt-3">
                <strong class="h5 text-info">{$_L['Primary Contact']}?</strong>
            </p>
        <div class="form-group mb-3">

            <label class="switch s-icons s-outline s-outline-primary">
                <input type="checkbox" id="is_primary_contact" {if $d['is_primary_contact'] eq '1'}checked{/if}>
                <span class="slider round"></span>
            </label>

        </div>

            {foreach $cf as $c}

                <strong>{$c['fieldname']}: </strong> {if get_custom_field_value($c['id'],$d['id']) neq ''} {get_custom_field_value($c['id'],$d['id'])} {else} N/A {/if} <br>

            {/foreach}

        </div>
    </div>
    <div class="col-md-6">
        <div class="p-2">
            <div class="form-group">
                <textarea class="form-control" id="contact_note" placeholder="{$_L['Contact Notes']}..." rows="6">{$d['notes']}</textarea>
            </div>



        </div>
    </div>
</div>




<hr>

<a href="{$_url}contacts/view/{$d->id}/edit/" class="btn btn-warning">{$_L['Edit']}</a>


{if $config['add_fund'] eq '1'}
    <hr>

    <h3>{$_L['Balance']} : <span class="amount">{$d->balance}</span></h3>
    <a href="javascript:void(0)" class="btn btn-primary add_fund">{$_L['Add Fund']}</a>
    <a href="javascript:void(0)" class="btn btn-danger return_fund">{$_L['Return Fund']}</a>
{/if}

{if $config['client_dashboard'] eq '1'}
    <hr>

    {if $d->autologin neq ''}
        <form class="form-horizontal" method="post">
            <div class="form-group">
                <div class="col-xs-12">
                    <div class="form-group h5">
                        <label for="auto_login_url">{$_L['Auto Login URL']}</label>
                        <input class="form-control" type="text" id="auto_login_url" name="auto_login_url" value="{$_url}client/autologin/{$d->autologin}">
                    </div>
                    <p class="help-block">
                        <a class="h6 text-info" href="{$_url}client/autologin/{$d->autologin}" target="_blank">{$_L['Login As Customer']}</a> |
                        <a href="{$_url}contacts/revoke_auto_login/{$d->id}/">{$_L['Revoke Auto Login']}</a> |
                        <a href="{$_url}contacts/gen_auto_login/{$d->id}/">{$_L['Re Generate URL']}</a>
                    </p>
                </div>
            </div>

        </form>

        {$extra_html_1}

    {else}
        <a href="{$_url}contacts/gen_auto_login/{$d->id}/" class="md-btn md-btn-primary"> {$_L['Create Auto Login URL']}</a>
    {/if}
{/if}






{if $config['accounting'] eq '1'}
    <hr>


    <table class="table table-striped margin bottom invoice-total">
        <thead>
        <tr>

            <th class="h5" colspan="3">{$_L['Accounting Summary']}</th>

        </tr>
        </thead>
        <tbody>
        <tr>

            <td class="h5"> {$_L['Total Income']}
            </td>
            <td class="text-center"><span class="h5 text-success amount" data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-a-pad="{$config['currency_decimal_digits']}" data-p-sign="{$config['currency_symbol_position']}" data-a-sign="{$config['currency_code']} " data-d-group="{$config['thousand_separator_placement']}">{$ti}</span></td>

        </tr>
        <tr>

            <td class="h5"> {$_L['Total Expense']}
            </td>
            <td class="text-center"><span class="h5 text-danger amount" data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-a-pad="{$config['currency_decimal_digits']}" data-p-sign="{$config['currency_symbol_position']}" data-a-sign="{$config['currency_code']} " data-d-group="{$config['thousand_separator_placement']}">{$te}</span></td>


        </tr>



        </tbody>
    </table>

    <table class="table invoice-total">
        <tbody>

        <tr>
            <td class="h5"><strong>{$happened} </strong></td>
            <td class="text-center"><strong><span class=" h5 text-info amount" data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-a-pad="{$config['currency_decimal_digits']}" data-p-sign="{$config['currency_symbol_position']}" data-a-sign="{$config['currency_code']} " data-d-group="{$config['thousand_separator_placement']}" >{$d_amount}</span></strong></td>
        </tr>
        </tbody>
    </table>
{/if}
