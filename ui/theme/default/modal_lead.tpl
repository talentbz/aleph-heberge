<div>
    <div class="panel shadow-none mb-0 rounded-0">
        <div class="panel-hdr">
            <h2>
                {if $act eq 'edit'}
                    {$_L['Edit']}
                {elseif $act eq 'view'}
                    {$lead->salutation} {$lead->first_name} {$lead->middle_name} {$lead->last_name}
                {else}
                    {$_L['New Lead']}
                {/if}
            </h2>
        </div>

        <div class="panel-container">
            <div class="panel-content">



                {if $act eq 'edit' || $act eq 'new'}

                    <form class="form-horizontal" id="ib_modal_form">


                        <div class="row">


                            <div class="col-md-12">



                                <div class="form-group"><label for="status">{$_L['Status']}</label>
                                    <select class="custom-select" id="status" name="status">

                                        {foreach $ls as $s}
                                            {if $act eq 'edit'}
                                                <option value="{$s['sname']}" {if $val['status'] eq $s['sname']}selected{/if}>{$s['sname']}</option>
                                            {else}
                                                <option value="{$s['sname']}" {if $s['is_default'] eq '1'}selected{/if}>{$s['sname']}</option>
                                            {/if}
                                        {/foreach}

                                    </select>
                                </div>


                                <div class="form-row mb-3">
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label for="salutation">{$_L['Salutation']}</label>
                                            <select class="custom-select" id="salutation" name="salutation">
                                                <option value="None">--{$_L['None']}--</option>
                                                {foreach $salutations as $salutation}
                                                    {if $act eq 'edit'}
                                                        <option value="{$salutation['sname']}" {if $val['salutation'] eq $salutation['sname']}selected{/if}>{$salutation['sname']}</option>
                                                    {else}
                                                        <option value="{$salutation['sname']}">{$salutation['sname']}</option>
                                                    {/if}

                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="form-group"><label for="first_name">{$_L['First Name']}</label>
                                            <input type="text" id="first_name" name="first_name" class="form-control" value="{$val['first_name']}">
                                        </div>
                                    </div>
{*                                    <div class="col-md-3">*}
{*                                        <div class="form-group">*}
{*                                            <label for="first_name">{$_L['Middle Name']}</label>*}
{*                                            <input type="text" id="middle_name" name="middle_name" class="form-control" value="{$val['middle_name']}">*}
{*                                        </div>*}
{*                                    </div>*}
                                    <div class="col-md-5">
                                        <div class="form-group"><label for="last_name">{$_L['Last Name']}<small class="red">*</small></label>

                                            <input type="text" id="last_name" name="last_name" class="form-control" value="{$val['last_name']}">

                                        </div>
                                    </div>
                                </div>







                                <div class="form-group"><label for="title">{$_L['Title']}</label>
                                    <input type="text" id="title" name="title" class="form-control" value="{$val['title']}">
                                </div>

                                <div class="form-group"><label for="company">{$_L['Company']}</label>
                                    <select class="custom-select" id="company" name="company">
                                        <option value="None">--{$_L['None']}--</option>
                                        {foreach $companies as $company}
                                            <option value="{$company['id']}" {if $val['company'] eq $company['company_name']}selected{/if}>{$company['company_name']}</option>
                                        {/foreach}
                                    </select>
                                </div>

                                <div class="form-group"><label for="email">{$_L['Email']}</label>
                                    <input type="text" id="email" name="email" class="form-control" value="{$val['email']}">
                                </div>

                                <div class="form-group"><label for="">{$_L['Phone']}</label>
                                    <input type="text" id="phone" name="phone" class="form-control" value="{$val['phone']}">
                                </div>



                                <div class="form-group"><label for="source">{$_L['Source']}</label>
                                    <select class="custom-select" id="source" name="source">
                                        <option value="None">--{$_L['None']}--</option>
                                        {foreach $sources as $source}
                                            <option value="{$source['sname']}">{$source['sname']}</option>
                                        {/foreach}
                                    </select>
                                </div>


                                <div class="form-group"><label for="industry">{$_L['Industry']}</label>
                                    <select class="custom-select" id="industry" name="industry">
                                        {foreach $industries as $industry}
                                            <option value="{$industry['industry']}" {if $val['industry'] eq $industry['industry']}selected{/if}>{$industry['industry']}</option>
                                        {/foreach}
                                    </select>
                                </div>


                                {*<div class="form-group"><label for="">{$_L['No. of Employees']}</label>*}
                                {*<div class="col-md-12">*}
                                {*<input type="text" id="" name="" class="form-control" value="{$val['']}">*}
                                {*</div>*}
                                {*</div>*}

                                {*<div class="form-group"><label for="rating">{$_L['Rating']}</label>*}
                                {*<div class="col-md-12">*}
                                {*<input type="text" id="rating" name="rating" class="form-control" value="{$val['rating']}">*}
                                {*</div>*}
                                {*</div>*}



                                <fieldset>
                                    <legend>{$_L['Address']}</legend>

                                    <div class="form-group"><label for="street">{$_L['Street']}</label>
                                        <textarea class="form-control" id="street" name="street" rows="2"></textarea>
                                    </div>

                                    <div class="form-group"><label for="city">{$_L['City']}</label>
                                        <input type="text" id="company" name="city" class="form-control" value="{$val['city']}">
                                    </div>

                                    <div class="form-group"><label for="state">{$_L['State Region']}</label>
                                        <input type="text" id="state" name="state" class="form-control" value="{$val['state']}">
                                    </div>

                                    <div class="form-group"><label for="zip">{$_L['ZIP Postal Code']}</label>
                                        <input type="text" id="zip" name="zip" class="form-control" value="{$val['zip']}">
                                    </div>

                                    <div class="form-group"><label for="country">{$_L['Country']}</label>
                                        <input type="text" id="country" name="country" class="form-control" value="{$val['country']}">
                                    </div>

                                </fieldset>

                                <fieldset class="mt-3">
                                    <legend>{$_L['Description']}</legend>

                                    <div class="form-group"><label for="memo">{$_L['Memo']}</label>
                                        <textarea class="form-control" id="memo" name="memo" rows="4"></textarea>
                                    </div>


                                </fieldset>



                            </div>




                        </div>




                        <input type="hidden" name="act" id="act" value="{$act}">
                        <input type="hidden" name="lid" id="lid" value="{$val['lid']}">

                        <div class="form-group">
                            <button class="btn btn-primary modal_submit my-3" type="submit" id="modal_submit"><i class="fal fa-check"></i> {$_L['Save']}</button>
                        </div>

                    </form>


                {else}


                    <div class="row">
                        <div class="col-md-3 ib_profile_width">

                            <img src="{$app_url}storage/system/profile-place-holder.jpg" class="rounded-circle img-fluid" alt=" ">

                        </div>

                        <div class="col-md-9">

                            <h5>{$lead->salutation} {$lead->first_name} {$lead->middle_name} {$lead->last_name}</h5>


                            <div id="application_ajaxrender" style="min-height: 200px;">
                                <p>

                                    <strong>{$_L['Full Name']}: </strong> {$lead->salutation} {$lead->first_name} {$lead->middle_name} {$lead->last_name} <br>
                                    <strong>{$_L['Company Name']}: </strong> {$lead->company} <br>
                                    <strong>{$_L['Email']}: </strong>  {$lead->email}  <br>
                                    <strong>{$_L['Phone']}: </strong>  {$lead->phone}  <br>
                                    <strong>{$_L['Address']}: </strong>  {$lead->street}  <br>
                                    <strong>{$_L['City']}: </strong>  {$lead->city}  <br>
                                    <strong>{$_L['State Region']}: </strong>  {$lead->state}  <br>
                                    <strong>{$_L['ZIP Postal Code']}: </strong>  {$lead->zip}  <br>
                                    <strong>{$_L['Country']}: </strong>  {$lead->country}  <br>




                                </p>

                                <hr>

                                <a href="#" class="btn btn-primary act_convert_to_customer"> {$_L['Convert to Customer']}</a>

                                <input type="hidden" name="v_lid" id="v_lid" value="{$lead->id}">

                                <hr>

                                <textarea class="form-control" id="v_memo" name="v_memo" rows="6">{$lead->memo}</textarea>

                                <button type="button" id="memo_update" class="btn btn-primary btn-block mt-3 act_memo_update">{$_L['Save']}</button>


                            </div>



                        </div>

                    </div>




                {/if}




            </div>
        </div>

    </div>
</div>
