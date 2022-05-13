{extends file="$layouts_admin"}



{block name="content"}
    <div class="row">
        <div class="col-md-6">



            <div class="panel" id="ui_settings">
                <div class="panel-hdr">
                    <h2>{$_L['Choose Features']}</h2>


                </div>

                <div class="panel-container">
                    <div class="panel-content">
                        <table class="table table-hover">
                            <tbody>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_accounting">{$_L['Accounting']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_accounting" {if get_option('accounting') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>

                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_invoicing">{$_L['Invoicing']} </label></td>
                                <td>

                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_invoicing" {if get_option('invoicing') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>

                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_pos">{$_L['POS']} </label></td>
                                <td>

                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_pos" {if get_option('pos') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>

                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_invoice_receipt_number">{$_L['Invoicing']} - {$_L['Receipt Number']}</label></td>
                                <td>

                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_invoice_receipt_number" {if get_option('invoice_receipt_number') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>

                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_show_business_number">{$_L['Invoicing']} - {$_L['Show Business Number']}</label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_show_business_number" {if get_option('show_business_number') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%">
                                    <label class="font-weight-bold" for="label_business_number">{$_L['Business Number Label Name']} </label> <br>

                                </td>
                                <td> <div class="form-group">
                                        <label class="font-weight-bold" for="label_business_number">{$_L['Name']}</label>
                                        <input class="form-control" type="text" id="label_business_number" name="label_business_number" value="{$config['label_business_number']}">

                                    </div></td>
                            </tr>



                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_quotes">{$_L['Quotes']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_quotes" {if get_option('quotes') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_delivery_challans">{$_L['Delivery Challans']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_delivery_challans" {if get_option('delivery_challans') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_companies">{$_L['Companies']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_companies" {if get_option('companies') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_fax_field">{$_L['Fax']} field </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_fax_field" {if get_option('fax_field') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_leads">{$_L['Leads']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_leads" {if get_option('leads') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_orders">{$_L['Orders']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_orders" {if get_option('orders') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            {if $config['orders'] eq '1'}

                                <tr>
                                    <td width="80%">
                                        <label class="font-weight-bold" for="config_order_method">{$_L['Order Method']} </label> <br>
                                    </td>
                                    <td>

                                        <select class="form-control" name="config_order_method" id="config_order_method">
                                            <option value="default" {if $config['order_method'] eq 'default'} selected{/if}>{$_L['Default']}</option>
                                            <option value="create_invoice_later" {if $config['order_method'] eq 'create_invoice_later'} selected{/if}>{$_L['Place Order, Create Invoice Later']}</option>

                                        </select>

                                    </td>
                                </tr>





                            {/if}

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_support">{$_L['Support']} </label></td>
                                <td>

                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_support" {if get_option('support') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_kb">{$_L['Knowledgebase']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_kb" {if get_option('kb') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>

                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_hrm">{$_L['HRM']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_hrm" {if get_option('hrm') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_projects">{$_L['Projects']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_projects" {if get_option('projects') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_tasks">{$_L['Tasks']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_tasks" {if get_option('tasks') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_create_task_from_ticket">{$_L['Create tasks automatically from ticket']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_create_task_from_ticket" {if get_option('create_task_from_ticket') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_calendar">{$_L['Calendar']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_calendar" {if get_option('calendar') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_documents">{$_L['Documents']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_documents" {if get_option('documents') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_subscriptions">{__('Subscriptions')} </label></td>
                                <td>

                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input id="config_subscriptions" type="checkbox" class="on_change_feature" data-feature="subscriptions" value="1" {if get_option('subscriptions') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>

                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_contracts">{__('Contracts')} </label></td>
                                <td>

                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_contracts" class="on_change_feature" data-feature="contracts" value="1" {if get_option('contracts') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>

                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_suppliers">{$_L['Suppliers']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_suppliers" {if get_option('suppliers') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>

                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_purchase">{$_L['Purchase']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_purchase" {if get_option('purchase') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_inventory">{$_L['Inventory']} </label></td>
                                <td>

                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_inventory" {if get_option('inventory') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>





                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_sms">{$_L['SMS']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_sms" {if get_option('sms') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_plugins">{$_L['Plugins']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_plugins" {if get_option('plugins') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_client_drive">Client Drive </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_client_drive" {if get_option('client_drive') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_allow_customer_registration">{$_L['Client Registration']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_allow_customer_registration" {if get_option('allow_customer_registration') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_allow_customer_registration">{$_L['Enable Language change on the client portal']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_allow_customer_change_language" {if get_option('allow_customer_change_language') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_recaptcha_in_client_login">{$_L['Enable Recaptcha in Client Login']}</label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_recaptcha_in_client_login" {if isset($config['config_recaptcha_in_client_login']) && $config['config_recaptcha_in_client_login'] == 1}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_recaptcha_in_admin_login">{$_L['Enable Recaptcha in Admin Login']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_recaptcha_in_admin_login" {if isset($config['config_recaptcha_in_admin_login']) && $config['config_recaptcha_in_admin_login'] == 1}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_customer_custom_username">{$_L['Username']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_customer_custom_username" {if get_option('customer_custom_username') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_contact_list_show_company_column">{$_L['Customer list show company']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_contact_list_show_company_column" {if get_option('contact_list_show_company_column') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_contact_list_show_group_column">{$_L['Customer list show group']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_contact_list_show_group_column" {if get_option('contact_list_show_group_column') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            <tr>
                                <td width="80%"><label class="font-weight-bold" for="config_tickets_assigned_sms_notification">{$_L['Send sms notification to admin when ticket is assigned']} </label></td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_tickets_assigned_sms_notification" {if get_option('tickets_assigned_sms_notification') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%">
                                    <label class="font-weight-bold" for="add_contact_remove_welcome_email">{$_L['Admin - Disable customer welcome email']} ?</label>

                                </td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="add_contact_remove_welcome_email" {if get_option('add_contact_remove_welcome_email') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%">
                                    <label class="font-weight-bold" for="config_add_fund">{$_L['Add Fund']} </label> <br>
                                    <span>{$_L['Option to enabled Add Fund to Client']}</span>
                                </td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_add_fund" {if get_option('add_fund') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            {if $config['add_fund'] eq '1'}



                                <tr>
                                    <td width="80%">
                                        <label class="font-weight-bold" for="add_fund_minimum_deposit">{$_L['Minimum Deposit']} </label> <br>
                                        <span>{$_L['Enter the minimum amount a client can add in a single transaction']}</span>
                                    </td>
                                    <td> <div class="form-group">
                                            <label class="font-weight-bold" for="add_fund_minimum_deposit">{$_L['Amount']}</label>
                                            <input class="form-control" type="text" id="add_fund_minimum_deposit" name="add_fund_minimum_deposit" value="{$config['add_fund_minimum_deposit']}">


                                        </div></td>
                                </tr>


                                <tr>
                                    <td width="80%">
                                        <label class="font-weight-bold" for="add_fund_maximum_deposit">{$_L['Maximum Deposit']} </label> <br>
                                        <span>{$_L['Enter the maximum amount a client can add in a single transaction']}</span>
                                    </td>
                                    <td> <div class="form-group">
                                            <label class="font-weight-bold" for="add_fund_maximum_deposit">{$_L['Amount']}</label>
                                            <input class="form-control" type="text" id="add_fund_maximum_deposit" name="add_fund_maximum_deposit" value="{$config['add_fund_maximum_deposit']}">


                                        </div></td>
                                </tr>

                                <tr>
                                    <td width="80%">
                                        <label class="font-weight-bold" for="config_add_fund_client">{$_L['Enable Add Fund Option from Client Portal']}</label> <br>
                                        <span>{$_L['Adding of funds by clients from the client dashboard']}</span>
                                    </td>
                                    <td>
                                        <label class="switch s-icons s-outline s-outline-primary">
                                            <input type="checkbox" id="config_add_fund_client" {if get_option('add_fund_client') eq '1'}checked{/if}>
                                            <span class="slider round"></span>
                                        </label>
                                    </td>
                                </tr>

                            {/if}

                            <tr>
                                <td width="80%">
                                    <label class="font-weight-bold" for="config_hide_expense_client">{$_L['Hide Expense from Client Portal']}</label> <br>

                                </td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" id="config_hide_expense_client" {if get_option('hide_expense_client') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>


                            {*<tr>*}
                            {*<td width="80%"><label class="font-weight-bold" for="config_client_dashboard">{$_L['Enable Client Dashboard']} </label></td>*}
                            {*<td> <input type="checkbox" {if get_option('client_dashboard') eq '1'}checked{/if} data-toggle="toggle" data-size="small" data-on="{$_L['Yes']}" data-off="{$_L['No']}" id="config_client_dashboard"></td>*}
                            {*</tr>*}

                            </tbody>
                        </table>



                    </div>
                </div>

            </div>


        </div>





    </div>
{/block}

{block name="script"}

    <script>

        $(function () {

                var _url = $("#_url").val();


            $('.on_change_feature').change(function() {

                $('#ui_settings').block({ message: null });

                let feature = $(this).data('feature');

                if($(this).prop('checked')){

                    $.post( _url+'settings/update_option/', { opt: feature, val: "1" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });

                }
                else{
                    $.post( _url+'settings/update_option/', { opt: feature, val: "0" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });
                }
            });

                $('#config_accounting').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "accounting", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "accounting", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });

                $('#config_invoicing').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "invoicing", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "invoicing", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_kb').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "kb", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "kb", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });

                $('#config_quotes').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "quotes", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "quotes", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_orders').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "orders", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "orders", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_documents').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "documents", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "documents", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_inventory').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "inventory", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "inventory", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


            $('#add_contact_remove_welcome_email').change(function() {

                $('#ui_settings').block({ message: null });


                if($(this).prop('checked')){

                    $.post( _url+'settings/update_option/', { opt: "add_contact_remove_welcome_email", val: "1" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });

                }
                else{
                    $.post( _url+'settings/update_option/', { opt: "add_contact_remove_welcome_email", val: "0" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });
                }
            });



                $('#config_leads').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "leads", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "leads", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_suppliers').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "suppliers", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "suppliers", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_support').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "support", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "support", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_purchase').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "purchase", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "purchase", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_tasks').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "tasks", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "tasks", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_calendar').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "calendar", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "calendar", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_hrm').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "hrm", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "hrm", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_companies').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "companies", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "companies", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_plugins').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "plugins", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "plugins", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });

            $('#config_pos').change(function() {

                $('#ui_settings').block({ message: null });


                if($(this).prop('checked')){

                    $.post( _url+'settings/update_option/', { opt: "pos", val: "1" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });

                }
                else{
                    $.post( _url+'settings/update_option/', { opt: "pos", val: "0" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });
                }
            });

                $('#config_customer_custom_username').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "customer_custom_username", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "customer_custom_username", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_projects').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "projects", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "projects", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_add_fund').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "add_fund", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "add_fund", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_invoice_receipt_number').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "invoice_receipt_number", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "invoice_receipt_number", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $("#add_fund_minimum_deposit").on("blur",function(e){
                    $('#ui_settings').block({ message: null });
                    $.post(base_url + 'settings/update_option/',{ opt: "add_fund_minimum_deposit", val: $("#add_fund_minimum_deposit").val() },function (data) {
                        if ($.isNumeric(data)) {
                            $('#ui_settings').unblock();
                            toastr.success(_L['Saved Successfully']);

                        }

                        else {
                            $('#ui_settings').unblock();
                            toastr.error(data);
                        }
                    })
                });

                $("#add_fund_maximum_deposit").on("blur",function(e){
                    $('#ui_settings').block({ message: null });
                    $.post(base_url + 'settings/update_option/',{ opt: "add_fund_maximum_deposit", val: $("#add_fund_maximum_deposit").val() },function (data) {
                        if ($.isNumeric(data)) {
                            $('#ui_settings').unblock();
                            toastr.success(_L['Saved Successfully']);

                        }

                        else {
                            $('#ui_settings').unblock();
                            toastr.error(data);
                        }
                    })
                });


                $("#config_order_method").on("change",function(e){
                    $('#ui_settings').block({ message: null });
                    $.post(base_url + 'settings/update_option/',{ opt: "order_method", val: $("#config_order_method").val() },function (data) {
                        if (data === 'ok') {
                            $('#ui_settings').unblock();
                            toastr.success(_L['Saved Successfully']);

                        }

                        else {
                            $('#ui_settings').unblock();
                            toastr.error(data);
                        }
                    })
                });


                $('#config_add_fund_client').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "add_fund_client", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "add_fund_client", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_allow_customer_registration').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "allow_customer_registration", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "allow_customer_registration", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });
            $('#config_allow_customer_change_language').change(function() {

                $('#ui_settings').block({ message: null });


                if($(this).prop('checked')){

                    $.post( _url+'settings/update_option/', { opt: "allow_customer_change_language", val: "1" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });

                }
                else{
                    $.post( _url+'settings/update_option/', { opt: "allow_customer_change_language", val: "0" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });
                }
            });


            $('#config_client_drive').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "client_drive", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "client_drive", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });

            $('#config_automatic_payment_reminder').change(function() {

                $('#ui_settings').block({ message: null });


                if($(this).prop('checked')){

                    $.post( _url+'settings/update_option/', { opt: "automatic_payment_reminder", val: "1" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });

                }
                else{
                    $.post( _url+'settings/update_option/', { opt: "automatic_payment_reminder", val: "0" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });
                }
            });


                $('#config_show_business_number').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "show_business_number", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "show_business_number", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $("#label_business_number").on("blur",function(e){
                    $('#ui_settings').block({ message: null });
                    $.post(base_url + 'settings/update_option/',{ opt: "label_business_number", val: $("#label_business_number").val() },function (data) {
                        toastr.success(_L['Saved Successfully']);
                        $('#ui_settings').unblock();
                    })
                });


                $('#config_fax_field').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "fax_field", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "fax_field", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_sms').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "sms", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "sms", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_recaptcha_in_client_login').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "config_recaptcha_in_client_login", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "config_recaptcha_in_client_login", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_recaptcha_in_admin_login').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "config_recaptcha_in_admin_login", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "config_recaptcha_in_admin_login", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_contact_list_show_company_column').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "contact_list_show_company_column", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "contact_list_show_company_column", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_contact_list_show_group_column').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "contact_list_show_group_column", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "contact_list_show_group_column", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


                $('#config_tickets_assigned_sms_notification').change(function() {

                    $('#ui_settings').block({ message: null });


                    if($(this).prop('checked')){

                        $.post( _url+'settings/update_option/', { opt: "tickets_assigned_sms_notification", val: "1" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'settings/update_option/', { opt: "tickets_assigned_sms_notification", val: "0" })
                            .done(function( data ) {
                                $('#ui_settings').unblock();
                                location.reload();
                            });
                    }
                });


            $('#config_delivery_challans').change(function() {

                $('#ui_settings').block({ message: null });


                if($(this).prop('checked')){

                    $.post( _url+'settings/update_option/', { opt: "delivery_challans", val: "1" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });

                }
                else{
                    $.post( _url+'settings/update_option/', { opt: "delivery_challans", val: "0" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });
                }
            });


            $('#config_hide_expense_client').change(function() {

                $('#ui_settings').block({ message: null });


                if($(this).prop('checked')){

                    $.post( base_url+'settings/update_option/', { opt: "hide_expense_client", val: "1" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });

                }
                else{
                    $.post( base_url+'settings/update_option/', { opt: "hide_expense_client", val: "0" })
                        .done(function( data ) {
                            $('#ui_settings').unblock();
                            location.reload();
                        });
                }
            });




        })

    </script>
{/block}
