

{block name="head"}

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />
    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;

        }
        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, {
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

<form class="form-horizontal" id="rform">

    <div class="form-group"><label for="account"><span class="h6">{$_L['Account Name']}</span></label>

        <input type="text" id="account" name="account" class="form-control" value="{$d['account']}">
    </div>

    <div class="row mt-2">
        <div class="col-md-6 ">
            <div class="form-group"><label for="code"><span class="h6">{$_L['Code']}</span></label>

                <input type="text" id="code" name="code" class="form-control" value="{$d['code']}">
            </div>

        </div>
        <div class="col-md-6 ">
            <div class="form-group h6"><label for="company_id"><span class="h6">{$_L['Company']}</span></label>

                <select id="company_id" name="company_id" class="form-control">
                    <option value="0">{$_L['None']}</option>
                    {foreach $companies as $company}
                        <option value="{$company['id']}" {if $d->cid eq ($company['id'])}selected{/if}>{$company['company_name']}</option>
                    {/foreach}
                </select>
            </div>


        </div>
    </div>

    <div class="row mt-2">
        <div class="col-md-6">
            <div class="form-group h6"><label for="edit_email"><span class="h6">{$_L['Email']}</span></label>

                <input type="text" id="edit_email" name="edit_email" class="form-control" value="{$d['email']}">
            </div>


        </div>
        <div class="col-md-6">
            <div class="form-group h6"><label for="edit_secondary_email"><span class="h6">{$_L['Secondary Email']}</span></label>
                <input type="text" id="edit_secondary_email" name="secondary_email" class="form-control" value="{$d['secondary_email']}">
            </div>


        </div>
    </div>

    <div class="row mt-2">
        <div class="col-md-6">
            <div class="form-group h6"><label for="phone"><span class="h6">{$_L['Phone']}</span></label>

                <input type="text" id="phone" name="phone" class="form-control" value="{$d['phone']}">
            </div>

        </div>
        <div class="col-md-6">
            <div class="form-group h6"><label for="company_id"><span class="h6">{$_L['Owner']}</span></label>

                <select class="form-control" name="owner_id" id="owner_id">
                    {foreach $owners as $owner}
                        <option value="{$owner->id}" {if $owner->id == $d->o}selected{/if} >{$owner->fullname}</option>
                    {/foreach}
                </select>
            </div>

        </div>
    </div>



    {if $config['show_business_number'] eq '1'}

        <div class="form-group h6">

            <label for="business_number"><span class="h6">{$config['label_business_number']}</span></label>

            <input type="text" id="business_number" name="business_number" class="form-control" value="{$d['business_number']}">
        </div>

    {/if}

    {if $config['fax_field']}

        <div class="form-group h6"><label for="phone"><span class="h6">{$_L['Fax']}</span></label>

            <input type="text" id="fax" name="fax" class="form-control" value="{$d['fax']}">
        </div>

    {/if}


    <div class="form-group h6"><label for="address"><span class="h6">{$_L['Address']}</span></label>

        <input type="text" id="address" name="address" class="form-control" value="{$d['address']}">
    </div>
    <div class="row mt-2">
        <div class="col-md-6">
            <div class="form-group h6"><label for="city"><span class="h6">{$_L['City']}</span></label>

                <input type="text" id="city" name="city" class="form-control" value="{$d['city']}">
            </div>

        </div>
        <div class="col-md-6">
            <div class="form-group h6"><label for="state"><span class="h6">{$_L['State Region']}</span></label>
                <input type="text" id="state" name="state" class="form-control" value="{$d['state']}">
            </div>

        </div>
    </div>

    <div class="row mt-2">
        <div class="col-md-4">
            <div class="form-group h6"><label for="zip"><span class="h6">{$_L['ZIP Postal Code']} </span></label>
                <input type="text" id="zip" name="zip" class="form-control" value="{$d['zip']}">
            </div>
        </div>
        <div class="col-md-8">
            <div class="form-group h6"><label for="country"><span class="h6">{$_L['Country']}</span></label>
                <select name="country" id="country" class="form-control">
                    <option value="">{$_L['Select Country']}</option>
                    {$countries}
                </select>
            </div>

        </div>
    </div>



    <div class="row mt-2">
        <div class="col-md-7">
            <div class="form-group h6"><label for="group"><span class="h6">{$_L['Group']} </span></label>
                <select class="form-control" name="group" id="group">
                    <option value="0" {if ($d['gid']) eq 0}selected{/if}>{$_L['None']}</option>
                    {foreach $gs as $g}
                        <option value="{$g['id']}" {if ($d['gid']) eq ($g['id'])}selected{/if}>{$g['gname']}</option>
                    {/foreach}
                </select>
            </div>


        </div>
        <div class="col-md-5">
            {if $config['accounting'] eq '1'}

                <div class="form-group"><label class="col-md-2 control-label h6" for="currency"><span class="h6">{$_L['Currency']}</span></label>
                    <select id="currency" name="currency" class="form-control">

                        {foreach $currencies as $currency}
                            <option value="{$currency['id']}"
                                    {if ($d['currency']) eq ($currency['id'])}selected="selected" {/if}>{$currency['cname']}</option>
                            {foreachelse}
                            <option value="0">{$config['home_currency']}</option>
                        {/foreach}

                    </select>
                </div>

            {/if}
        </div>
    </div>












    {if $config['client_dashboard'] eq '1'}

    {if $config['customer_custom_username']}

        <div class="form-group h6"><label for="username"><span class="h6">{$_L['Username']} </span></label>

            <input type="text" id="username" name="username" class="form-control" value="{$d['username']}">
        </div>


        {/if}


        <div class="form-group h6"><label for="password"><span class="h6">{$_L['Password']}</span> </label>

            <input type="password" id="password" name="password" class="form-control" autocomplete="new-password">

            <span class="help-block text-info h6">{$_L['password_change_help']}</span>
        </div>

    {/if}



    {foreach $fs as $f}
        <div class="form-group"><label for="cf{$f['id']}">{$f['fieldname']}</label>
            {if ($f['fieldtype']) eq 'text'}


                <input type="text" id="cf{$f['id']}" name="cf{$f['id']}" class="form-control" value="{if get_custom_field_value($f['id'],$d['id']) neq ''} {get_custom_field_value($f['id'],$d['id'])}{/if}">
                {if ($f['description']) neq ''}
                    <span class="help-block">{$f['description']}</span>
                {/if}

            {elseif ($f['fieldtype']) eq 'password'}

                <input type="password" id="cf{$f['id']}" name="cf{$f['id']}" class="form-control" value="{if get_custom_field_value($f['id'],$d['id']) neq ''} {get_custom_field_value($f['id'],$d['id'])}{/if}">
                {if ($f['description']) neq ''}
                    <span class="help-block">{$f['description']}</span>
                {/if}

            {elseif ($f['fieldtype']) eq 'dropdown'}
                <select id="cf{$f['id']}" name="cf{$f['id']}" class="form-control">
                    {foreach explode(',',$f['fieldoptions']) as $fo}
                        <option value="{$fo}" {if get_custom_field_value($f['id'],$d['id']) eq $fo} selected="selected" {/if}>{$fo}</option>
                    {/foreach}
                </select>
                {if ($f['description']) neq ''}
                    <span class="help-block">{$f['description']}</span>
                {/if}

            {elseif ($f['fieldtype']) eq 'textarea'}

                <textarea id="cf{$f['id']}" name="cf{$f['id']}" class="form-control" rows="3">{if get_custom_field_value($f['id'],$d['id']) neq ''} {get_custom_field_value($f['id'],$d['id'])}{/if}</textarea>
                {if ($f['description']) neq ''}
                    <span class="help-block">{$f['description']}</span>
                {/if}

            {else}
            {/if}
        </div>
    {/foreach}

    <div class="form-group"><label for="cid"><span class="h6">{$_L['Type']}</span> </label>

        <div class="checkbox">
            <label>
                <input type="checkbox" class="custom-checkbox" name="customer" value="Customer" {if $d->type == 'Customer,Supplier' || $d->type == 'Customer' } checked {/if}>
                {$_L['Customer']}
            </label>
        </div>

        {if $config['suppliers'] eq '1'}
            <div class="checkbox">
                <label>
                    <input type="checkbox" class="custom-checkbox" name="supplier" value="Supplier"  {if $d->type == 'Customer,Supplier' || $d->type == 'Supplier' } checked {/if}>
                    {$_L['Supplier']}
                </label>
            </div>
        {/if}
    </div>

    <div class="form-group"><label for="tags"><span class="h6">{$_L['Tags']}</span></label>

        <select name="tags[]" id="tags"  class="form-control" multiple="multiple">
            {foreach $tags as $tag}
                <option value="{$tag['text']}" {if in_array($tag['text'],$dtags)}selected="selected"{/if}>{$tag['text']}</option>
            {/foreach}

        </select>
    </div>



    <div class="form-group">
        <button class="btn btn-primary" type="submit" id="submit"><i class="fal fa-check"></i> {$_L['Submit']}</button>
    </div>



    <input type="hidden" name="fcid" id="fcid" value="{$d['id']}">


</form>
