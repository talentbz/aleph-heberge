<div>
    <div class="panel shadow-none mb-0">
        <div class="panel-hdr">
            <h2>{$company->company_name}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">

                <input type="hidden" id="base_cid" name="base_cid" value="{$company->id}">

                <div class="row">
                    <div class="col-md-3 ib_profile_width">

                        <div class="panel panel-default" id="ibox_panel">

                            <div class="panel-body">
                                <div class="my-3 text-center">


                                    {if $company->logo_url neq ''}
                                        <img class="img-fluid" src="{$app_url}storage/companies/{$company->logo_url}">
                                    {else}
                                        <img src="{$app_url}/ui/assets/img/default_company.png">
                                    {/if}


                                </div>



                            </div>

                            <div class="panel-body list-group border-bottom m-t-n-lg">
                                <a href="#" id="summary" class="list-group-item active li_summary"><span class="fal fa-chart-bar mr-2"></span> {$_L['Summary']} </a>
                                <a href="#" id="memo" class="list-group-item li_memo"><span class="fal fa-file-alt mr-2"></span> {$_L['Memo']}</a>
                                <a href="#" id="customers" class="list-group-item li_customers"><span class="fal fa-users mr-2"></span> {$_L['Customers']} <span class="badge badge-primary float-right">{Companies::countCustomers($company->id)}</span></a>

                                <a href="#" id="invoices" class="list-group-item li_invoices"><span class="fal fa-credit-card mr-2"></span> {$_L['Invoices']} <span class="badge badge-primary float-right">{Companies::countInvoices($company->id)}</span></a>

                                <a href="#" id="quotes" class="list-group-item li_quotes"><span class="fal fa-file mr-2"></span> {$_L['Quotes']} <span class="badge badge-primary float-right">{Companies::countQuotes($company->id)}</span></a>


                                <a href="#" id="orders" class="list-group-item li_orders"><span class="fal fa-server mr-2"></span> {$_L['Orders']} <span class="badge badge-primary float-right">{Companies::countOrders($company->id)}</span></a>
                                {*<a href="#" id="files" class="list-group-item li_files"><span class="fal fa-file-o"></span> {$_L['Files']} <span class="label label-info pull-right">{Companies::countDocuments($company->id)}</span></a>*}
                                <a href="#" id="transactions" class="list-group-item li_transactions"><span class="fal fa-th-list mr-2"></span> {$_L['Transactions']} <span class="badge badge-primary float-right">{Companies::countTransactions($company->id)}</span></a>


                            </div>



                        </div>

                    </div>

                    <div class="col-md-9">

                        <!-- START TIMELINE -->
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>{$company->company_name}</h5>
                            </div>

                            <div class="ibox-content" id="ibox_form" style="position: static; zoom: 1;">


                                <div id="application_ajaxrender" style="min-height: 200px;">






                                    {*<hr>*}


                                    {*<table class="table table-hover margin bottom invoice-total">*}
                                    {*<thead>*}
                                    {*<tr>*}

                                    {*<th colspan="3">Accounting Summary</th>*}

                                    {*</tr>*}
                                    {*</thead>*}
                                    {*<tbody>*}
                                    {*<tr>*}

                                    {*<td> Total Income*}
                                    {*</td>*}
                                    {*<td class="text-center"><span class="label label-primary amount" data-a-dec="." data-a-sep="," data-a-pad="true" data-p-sign="p" data-a-sign="$ " data-d-group="3">$ 0.00</span></td>*}

                                    {*</tr>*}
                                    {*<tr>*}

                                    {*<td> Total Expense*}
                                    {*</td>*}
                                    {*<td class="text-center"><span class="label label-danger amount" data-a-dec="." data-a-sep="," data-a-pad="true" data-p-sign="p" data-a-sign="$ " data-d-group="3">$ 0.00</span></td>*}


                                    {*</tr>*}



                                    {*</tbody>*}
                                    {*</table>*}

                                    {*<table class="table invoice-total">*}
                                    {*<tbody>*}

                                    {*<tr>*}
                                    {*<td><strong>Loss :</strong></td>*}
                                    {*<td><strong><span class="label label-danger amount" data-a-dec="." data-a-sep="," data-a-pad="true" data-p-sign="p" data-a-sign="$ " data-d-group="3" style="font-size: 11px;">$ 0.00</span></strong></td>*}
                                    {*</tr>*}
                                    {*</tbody>*}
                                    {*</table>*}

                                </div>

                            </div>
                        </div>
                        <!-- END TIMELINE -->

                    </div>

                </div>


            </div>
        </div>
    </div>
</div>
