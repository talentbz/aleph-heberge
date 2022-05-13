<div>
    <div class="panel shadow-none mb-0">
        <div class="panel-hdr">
            <h2>
                {$_L['New Expense']}
            </h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">

                <form class="form-horizontal" method="post" id="project_expense_form" role="form">
                    <div class="form-group">
                        <label for="account"><span class="h6">{$_L['Account']}</span></label>
                        <select id="account" name="account_id" class="form-control">
                            <option value="">{$_L['Choose an Account']}</option>

                            {foreach $accounts as $account}
                                <option value="{$account->id}">{$account->account}</option>
                            {/foreach}

                        </select>
                    </div>

                    <div class="form-group">
                        <label for="code"><span class="h6">{$_L['Code']}</span></label>
                        <input type="text" class="form-control" id="code" name="code" value="{predict_next_serial($config,'expense')}">
                    </div>



                    <div class="form-group">
                        <label for="description"><span class="h6 ">{$_L['Description']}</span></label>
                        <input type="text" class="form-control" id="description" name="description">


                    </div>




                    <div class="row my-3">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="date"><span class="h6">{$_L['Date']}</span></label>
                                <input type="text" class="form-control datepicker"  value="{date('Y-m-d')}" name="date" id="date" data-date-format="yyyy-mm-dd" data-auto-close="true">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="currency"><span class="h6">{$_L['Currency']}</span></label>
                                <select id="currency" name="currency" class="form-control">

                                    <option value="">{$_L['None']}</option>

                                    {foreach $currencies as $currency}
                                        <option value="{$currency['iso_code']}" {if $config['home_currency'] eq $currency['iso_code']}selected{/if}
                                                {if isset($currencies_all[$currency['iso_code']])}
                                            data-a-sign="{$currencies_all[$currency['iso_code']]['symbol']}" data-a-sep="{$currencies_all[$currency['iso_code']]['thousands_separator']}" data-a-dec="{$currencies_all[$currency['iso_code']]['decimal_mark']}" {if ($currencies_all[$currency['iso_code']]['symbol_first'] == true)} data-p-sign="p" {else} data-p-sign="s" {/if}
                                                {/if}>{$currency['iso_code']}</option>
                                    {/foreach}

                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="amount"><span class="h6">{$_L['Amount']}</span></label>
                                <input type="text" class="form-control amount" id="amount" name="amount">
                            </div>
                        </div>
                    </div>













                    <div class="row my-3">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="company"><span class="h6">{$_L['Company']}</span></label>
                                <select id="company" name="company_id" class="form-control">
                                    <option value="0">{$_L['None']}</option>
                                    {foreach $companies as $company}
                                        <option value="{$company->id}">{$company->company_name}</option>
                                    {/foreach}


                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="payee"><span class="h6">{$_L['Payee']}</span></label>
                                <select id="payee" name="payee" class="form-control">
                                    <option value="0">{$_L['Choose Contact']}</option>
                                    {foreach $payees as $payee}
                                        <option value="{$payee->id}">{$payee->account} {if $payee->email} ({$payee->email}) {/if}</option>
                                    {/foreach}

                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="staff_id"><span class="h6">{$_L['Staff']}</span></label>
                                <select id="staff_id" name="staff_id" class="form-control">
                                    <option value="0">{$_L['None']}</option>
                                    {foreach $staffs as $staff}
                                        <option value="{$staff->id}">{$staff->fullname}</option>
                                    {/foreach}


                                </select>
                            </div>
                        </div>
                    </div>




                    <div class="row my-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="cats"><span class="h6">{$_L['Category']}</span></label>
                                <select id="cats" name="category" class="form-control">
                                    <option value="Uncategorized">{$_L['Uncategorized']}</option>

                                    {foreach $categories as $category}
                                        <option value="{$category->id}">{$category->name}</option>
                                    {/foreach}

                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="pmethod"><span class="h6">{$_L['Method']}</span></label>
                                <select id="pmethod" name="method" class="form-control">
                                    <option value="">{$_L['Select Payment Method']}</option>
                                    {foreach $methods as $method}
                                        <option value="{$method->name}">{$method->name}</option>
                                    {/foreach}


                                </select>
                            </div>
                        </div>
                    </div>




                    <div class="form-group">
                        <label for="status"><span class="h6">{$_L['Status']}</span></label>
                        <select class="form-control" name="status" id="status">
                            <option value="Cleared">{$_L['Cleared']}</option>
                            <option value="Uncleared">{$_L['Uncleared']}</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="ref"><span class="h6">{$_L['Ref']}#</span></label>
                        <input type="text" class="form-control" id="ref" name="ref">
                    </div>




                    <div class="form-group">
                        <input type="hidden" name="attachments" id="attachments" value="">
                        <input type="hidden" name="project_id" value="{{$project->id}}">
                        <button type="submit" id="submit" class="btn btn-primary">{$_L['Submit']}</button>
                    </div>
                </form>


            </div>
        </div>
    </div>
</div>
