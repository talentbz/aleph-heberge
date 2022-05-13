{extends file="hostbilling/admin/contact_base.tpl"}


{block name="inner_content"}

    <div class="alert alert-danger" id="emsg" style="display: none;">
        <span id="emsgbody"></span>
    </div>

    <form class="form-horizontal" id="edit_form">

        <div class="form-group"><label for="account"><span class="h6">{$_L['Account Name']}</span></label>

            <input type="text" id="account" name="account" class="form-control" value="{$contact->account}">
        </div>

        <div class="row mt-2">
            <div class="col-md-6 ">
                <div class="form-group"><label for="code"><span class="h6">{$_L['Code']}</span></label>

                    <input type="text" id="code" name="code" class="form-control" value="{$contact->code}">
                </div>

            </div>
            <div class="col-md-6 ">
                <div class="form-group h6"><label for="company_id"><span class="h6">{$_L['Company']}</span></label>

                    <select id="company_id" name="company_id" class="form-control">
                        <option value="0">{$_L['None']}</option>
                        {foreach $companies as $company}
                            <option value="{$company['id']}" {if $contact->cid eq ($company['id'])}selected{/if}>{$company['company_name']}</option>
                        {/foreach}
                    </select>
                </div>


            </div>
        </div>

        <div class="row mt-2">
            <div class="col-md-6">
                <div class="form-group h6"><label for="edit_email"><span class="h6">{$_L['Email']}</span></label>

                    <input type="text" id="edit_email" name="edit_email" class="form-control" value="{$contact['email']}">
                </div>


            </div>
            <div class="col-md-6">
                <div class="form-group h6"><label for="edit_secondary_email"><span class="h6">{$_L['Secondary Email']}</span></label>
                    <input type="text" id="edit_secondary_email" name="secondary_email" class="form-control" value="{$contact['secondary_email']}">
                </div>


            </div>
        </div>

        <div class="row mt-2">
            <div class="col-md-6">
                <div class="form-group h6"><label for="phone"><span class="h6">{$_L['Phone']}</span></label>

                    <input type="text" id="phone" name="phone" class="form-control" value="{$contact['phone']}">
                </div>

            </div>
            <div class="col-md-6">
                <div class="form-group h6"><label for="company_id"><span class="h6">{$_L['Owner']}</span></label>

                    <select class="form-control" name="owner_id" id="owner_id">
                        {foreach $owners as $owner}
                            <option value="{$owner->id}" {if $owner->id == $contact->o}selected{/if} >{$owner->fullname}</option>
                        {/foreach}
                    </select>
                </div>

            </div>
        </div>



        {if $config['show_business_number'] eq '1'}

            <div class="form-group h6">

                <label for="business_number"><span class="h6">{$config['label_business_number']}</span></label>

                <input type="text" id="business_number" name="business_number" class="form-control" value="{$contact['business_number']}">
            </div>

        {/if}

        {if $config['fax_field']}

            <div class="form-group h6"><label for="phone"><span class="h6">{$_L['Fax']}</span></label>

                <input type="text" id="fax" name="fax" class="form-control" value="{$contact['fax']}">
            </div>

        {/if}


        <div class="form-group h6"><label for="address"><span class="h6">{$_L['Address']}</span></label>

            <input type="text" id="address" name="address" class="form-control" value="{$contact['address']}">
        </div>
        <div class="row mt-2">
            <div class="col-md-6">
                <div class="form-group h6"><label for="city"><span class="h6">{$_L['City']}</span></label>

                    <input type="text" id="city" name="city" class="form-control" value="{$contact['city']}">
                </div>

            </div>
            <div class="col-md-6">
                <div class="form-group h6"><label for="state"><span class="h6">{$_L['State Region']}</span></label>
                    <input type="text" id="state" name="state" class="form-control" value="{$contact['state']}">
                </div>

            </div>
        </div>

        <div class="row mt-2">
            <div class="col-md-4">
                <div class="form-group h6"><label for="zip"><span class="h6">{$_L['ZIP Postal Code']} </span></label>
                    <input type="text" id="zip" name="zip" class="form-control" value="{$contact['zip']}">
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
                        <option value="0" {if ($contact['gid']) eq 0}selected{/if}>{$_L['None']}</option>
                        {foreach $gs as $g}
                            <option value="{$g['id']}" {if ($contact['gid']) eq ($g['id'])}selected{/if}>{$g['gname']}</option>
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
                                        {if ($contact['currency']) eq ($currency['id'])}selected="selected" {/if}>{$currency['cname']}</option>
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

                    <input type="text" id="username" name="username" class="form-control" value="{$contact['username']}">
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


                    <input type="text" id="cf{$f['id']}" name="cf{$f['id']}" class="form-control" value="{if get_custom_field_value($f['id'],$contact['id']) neq ''} {get_custom_field_value($f['id'],$contact['id'])}{/if}">
                    {if ($f['description']) neq ''}
                        <span class="help-block">{$f['description']}</span>
                    {/if}

                {elseif ($f['fieldtype']) eq 'password'}

                    <input type="password" id="cf{$f['id']}" name="cf{$f['id']}" class="form-control" value="{if get_custom_field_value($f['id'],$contact['id']) neq ''} {get_custom_field_value($f['id'],$contact['id'])}{/if}">
                    {if ($f['description']) neq ''}
                        <span class="help-block">{$f['description']}</span>
                    {/if}

                {elseif ($f['fieldtype']) eq 'dropdown'}
                    <select id="cf{$f['id']}" name="cf{$f['id']}" class="form-control">
                        {foreach explode(',',$f['fieldoptions']) as $fo}
                            <option value="{$fo}" {if get_custom_field_value($f['id'],$contact['id']) eq $fo} selected="selected" {/if}>{$fo}</option>
                        {/foreach}
                    </select>
                    {if ($f['description']) neq ''}
                        <span class="help-block">{$f['description']}</span>
                    {/if}

                {elseif ($f['fieldtype']) eq 'textarea'}

                    <textarea id="cf{$f['id']}" name="cf{$f['id']}" class="form-control" rows="3">{if get_custom_field_value($f['id'],$contact['id']) neq ''} {get_custom_field_value($f['id'],$contact['id'])}{/if}</textarea>
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
                    <input type="checkbox" class="custom-checkbox" name="customer" value="Customer" {if $contact->type == 'Customer,Supplier' || $contact->type == 'Customer' } checked {/if}>
                    {$_L['Customer']}
                </label>
            </div>

            {if $config['suppliers'] eq '1'}
                <div class="checkbox">
                    <label>
                        <input type="checkbox" class="custom-checkbox" name="supplier" value="Supplier"  {if $contact->type == 'Customer,Supplier' || $contact->type == 'Supplier' } checked {/if}>
                        {$_L['Supplier']}
                    </label>
                </div>
            {/if}
        </div>

        <div class="form-group"><label for="tags"><span class="h6">{$_L['Tags']}</span></label>

            <select name="tags[]" id="tags"  class="form-control" multiple="multiple">
                {foreach $tags as $tag}
                    <option value="{$tag['text']}" {if in_array($tag['text'],$contacttags)}selected="selected"{/if}>{$tag['text']}</option>
                {/foreach}

            </select>
        </div>



        <div class="form-group">
            <button class="btn btn-primary" type="submit" id="submit"><i class="fal fa-check"></i> {$_L['Submit']}</button>
        </div>



        <input type="hidden" name="fcid" id="fcid" value="{$contact['id']}">


    </form>


{/block}

{block name="script"}
    <script>
        $(function () {

            $("#country").select2();


            $('#tags').select2({
                tags: true,
                tokenSeparators: [','],
            });

            $('#company_id').select2();


            let $edit_form = $('#edit_form');

            $edit_form.on('submit',function (event) {
                event.preventDefault();
                $.post(base_url + 'contacts/edit-post/', $edit_form.serialize())
                    .done(function (data) {

                        if ($.isNumeric(data)) {

                            location.reload();
                        }
                        else {

                            $("#emsgbody").html(data);
                            $("#emsg").show("slow");
                        }
                    });
            });


        });
    </script>
{/block}
