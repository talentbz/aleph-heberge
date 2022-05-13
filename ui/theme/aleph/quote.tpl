{extends file="$layouts_admin"}
{block name="content"}
    <div class="row">
        <div class="col-lg-12">
            <div class="form-group mb-3">
                <label for="exampleInputEmail1">{$_L['Unique Quote URL']}:</label>
                <input type="text" class="form-control" id="invoice_public_url" onClick="this.setSelectionRange(0, this.value.length)" value="{$_url}client/q/{$d['id']}/token_{$d['vtoken']}">
            </div>
        </div>
        <div class="col-lg-12"  id="application_ajaxrender">
            <div class="panel" id="ibox">
                <div class="panel-hdr">


                    <h2> {$d['invoicenum']}{if $d['cn'] neq ''} {$d['cn']} {else} {$d['id']} {/if}</h2>




                    <div class="panel-toolbar">
                        <input type="hidden" name="iid" value="{$d['id']}" id="iid">
                        <div class="btn-group flex-wrap" role="group" aria-label="...">


                            <div class="btn-group" role="group">
                                <button type="button" class="btn  btn-success btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fal fa-envelope-o"></i>  {$_L['Send Email']}
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="dropdown-item"><a href="#" id="mail_quote_created">{$_L['Quote Created']}</a></li>

                                </ul>
                            </div>

                            <div class="btn-group" role="group">
                                <button type="button" class="btn  btn-dark btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fal fa-envelope-o"></i>  {$_L['SMS']}
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="dropdown-item"><a href="#" id="sms_quote_created">{$_L['Quote Created']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="sms_quote_accepted">{$_L['Quote Accepted']}</a></li>
                                    <li class="dropdown-item"><a href="#" id="sms_quote_cancelled">{$_L['Quote Cancelled']}</a></li>

                                </ul>
                            </div>


                            <div class="btn-group" role="group">
                                <button type="button" class="btn  btn-success btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fal fa-ellipsis-v"></i>  {$_L['Mark As']}
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    {if $d['stage'] neq 'Draft'}
                                        <li class="dropdown-item"><a href="#" id="mark_draft">{$_L['Draft']}</a></li>
                                    {/if}
                                    {if $d['stage'] neq 'Delivered'}
                                        <li class="dropdown-item"><a href="#" id="mark_delivered">{$_L['Delivered']}</a></li>
                                    {/if}
                                    {if $d['stage'] neq 'On Hold'}
                                        <li class="dropdown-item"><a href="#" id="mark_on_hold">{$_L['On Hold']}</a></li>
                                    {/if}
                                    {if $d['stage'] neq 'Accepted'}
                                        <li class="dropdown-item"><a href="#" id="mark_accepted">{$_L['Accepted']}</a></li>
                                    {/if}

                                    {if $d['stage'] neq 'Lost'}
                                        <li class="dropdown-item"><a href="#" id="mark_lost">{$_L['Lost']}</a></li>
                                    {/if}

                                    {if $d['stage'] neq 'Dead'}
                                        <li class="dropdown-item"><a href="#" id="mark_dead">{$_L['Dead']}</a></li>
                                    {/if}

                                </ul>
                            </div>



                            <a href="{$_url}client/q/{$d['id']}/token_{$d['vtoken']}" target="_blank" class="btn btn-primary  btn-sm"><i class="fal fa-paper-plane-o"></i> {$_L['Preview']}</a>
                            <a href="{$_url}quotes/edit/{$d['id']}/" class="btn btn-warning  btn-sm"><i class="fal fa-pencil"></i> {$_L['Edit']}</a>

                            <div class="btn-group" role="group">
                                <button type="button" class="btn  btn-success btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fal fa-file-pdf-o"></i>
                                    {$_L['PDF']}
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="dropdown-item"><a href="{$_url}client/qpdf/{$d['id']}/token_{$d['vtoken']}/view" target="_blank">{$_L['View PDF']}</a></li>
                                    <li class="dropdown-item"><a href="{$_url}client/qpdf/{$d['id']}/token_{$d['vtoken']}/dl">{$_L['Download PDF']}</a></li>
                                </ul>
                            </div>
                            <button type="button" class="btn  btn-danger btn-sm" id="convert_invoice"><i class="fal fa-plus"></i> {$_L['Convert to Invoice']}</button>
                            {*<a href="{$_url}iview/print/{$d['id']}/token_{$d['vtoken']}" target="_blank" class="btn btn-primary  btn-sm"><i class="fal fa-print"></i> {$_L['Print']}</a>*}


                        </div>
                    </div>

                </div>

                <div class="panel-container">
                    <div class="panel-content">


                        {if $d['stage'] eq 'Lost'}
                            <div id="ribbon-alert-container">
                                <a href="javascript:void(0)" id="ribbon">{$_L['Lost']}</a>
                            </div>
                        {elseif $d['stage'] eq 'Accepted'}
                            <div id="ribbon-container">
                                <a href="javascript:void(0)" id="ribbon">{$_L['Accepted']}</a>

                            </div>
                        {elseif $d['stage'] eq 'Delivered'}
                            <div id="ribbon-container">
                                <a href="javascript:void(0)" id="ribbon">{$_L['Delivered']}</a>
                            </div>
                        {elseif $d['stage'] eq 'Draft'}
                            <div id="ribbon-container">
                                <a href="javascript:void(0)" id="ribbon">{$_L['Draft']}</a>
                            </div>
                        {elseif $d['stage'] eq 'Dead'}
                            <div id="ribbon-alert-container">
                                <a href="javascript:void(0)" id="ribbon">{$_L['Dead']}</a>
                            </div>
                        {elseif $d['stage'] eq 'On Hold'}
                            <div id="ribbon-alert-container">
                                <a href="javascript:void(0)" id="ribbon">{$_L['On Hold']}</a>
                            </div>

                        {else}
                            <div id="ribbon-container">

                                <a href="javascript:void(0)" id="ribbon">{$d['stage']}</a>
                            </div>
                        {/if}

                        <div class="invoice">
                            <header class="clearfix">
                                <div class="row">
                                    <div class="col-md-12 mt-md">
                                        <h2 class="h2 mt-none mb-sm text-dark text-bold">{$config['CompanyName']}</h2>
                                        <h4 class="h4 m-none text-dark text-bold">#{$d['invoicenum']}{if $d['cn'] neq ''} {$d['cn']} {else} {$d['id']} {/if}</h4>

                                    </div>

                                </div>
                            </header>
                            <div class="bill-info">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="bill-to">
                                            <p class="h5 mb-xs text-dark text-semibold"><strong>{$_L['Recipient']}:</strong></p>
                                            <address>
                                                {if $a['company'] neq ''}
                                                    {$a['company']}
                                                    <br>
                                                    {$_L['ATTN']}: {$d['account']}
                                                    <br>
                                                {else}
                                                    {$d['account']}
                                                    <br>
                                                {/if}

                                                {$a['address']} <br>
                                                {$a['city']} <br>
                                                {$a['state']} - {$a['zip']} <br>
                                                {$a['country']}
                                                <br>
                                                <strong>{$_L['Phone']}:</strong> {$a['phone']}
                                                <br>
                                                <strong>{$_L['Email']}:</strong> {$a['email']}
                                                {foreach $cf as $cfs}
                                                    <br>
                                                    <strong>{$cfs['fieldname']}: </strong> {get_custom_field_value($cfs['id'],$a['id'])}
                                                {/foreach}


                                            </address>





                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="bill-data text-right">

                                            <div class="ib">
                                                <img src="{$app_url}storage/system/{$config['logo_default']}" alt="Logo" style="margin-bottom: 15px;">

                                            </div>

                                            <address class="ib mr-xlg">
                                                {$config['caddress']}
                                            </address>

                                            <p class="mb-none mt-lg">
                                                <span class="text-dark">{$_L['Date Created']}:</span>
                                                <span class="value">{date( $config['df'], strtotime($d['datecreated']))}</span>
                                            </p>
                                            <p class="mb-none">
                                                <span class="text-dark">{$_L['Expiry Date']}:</span>
                                                <span class="value">{date( $config['df'], strtotime($d['validuntil']))}</span>
                                            </p>
                                            <h2> {$_L['Total']}: <span class="amount">{$d['total']}</span> </h2>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <hr>

                                    <strong>{$d['subject']}</strong>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <hr>
                                    {$d['proposal']}
                                    <hr>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table invoice-items">
                                    <thead>
                                    <tr class="h4 text-dark">
                                        <th id="cell-id" class="text-semibold">#</th>
                                        <th id="cell-item" class="text-semibold">{$_L['Item']}</th>

                                        <th id="cell-price" class="text-center text-semibold">{$_L['Price']}</th>
                                        <th id="cell-qty" class="text-center text-semibold">{$_L['Quantity']}</th>
                                        <th id="cell-total" class="text-center text-semibold">{$_L['Total']}</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    {foreach $items as $item}
                                        <tr>
                                            <td>{$item['itemcode']}</td>
                                            <td class="text-semibold text-dark">{$item['description']}</td>

                                            <td class="text-center amount">{$item['amount']}</td>
                                            <td class="text-center">{$item['qty']}</td>
                                            <td class="text-center amount">{$item['total']}</td>
                                        </tr>
                                    {/foreach}

                                    </tbody>
                                </table>
                            </div>

                            <div class="invoice-summary">
                                <div class="row">
                                    <div class="col-md-4 offset-md-8">
                                        <table class="table h5 text-dark">
                                            <tbody>
                                            <tr class="b-top-none">
                                                <td colspan="2">{$_L['Subtotal']}</td>
                                                <td class="text-left amount">{$d['subtotal']}</td>
                                            </tr>
                                            {if ($d['discount']) neq '0.00'}
                                                <tr>
                                                    <td colspan="2">{$_L['Discount']}</td>
                                                    <td class="text-left amount">{$d['discount']}</td>
                                                </tr>
                                            {/if}
                                            <tr>
                                                <td colspan="2">{$d['taxname']}</td>
                                                <td class="text-left amount">{$d['tax1']}</td>
                                            </tr>

                                            <tr class="h4">
                                                <td colspan="2">{$_L['Grand Total']}</td>
                                                <td class="text-left amount">{$d['total']}</td>
                                            </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <hr>
                                    {$d['customernotes']}
                                </div>
                            </div>
                        </div>




                        {*{if ($d['notes']) neq ''}*}
                        {*<div class="well m-t">*}
                        {*{$d['notes']}*}
                        {*</div>*}
                        {*{/if}*}





                    </div>
                </div>


            </div>
        </div>
    </div>

    <input type="hidden" id="_lan_msg_confirm" value="{$_L['are_you_sure']}">

    <input type="hidden" id="admin_email" value="{$user->username}">
{/block}

{block name="script"}
<script>
    $(document).ready(function () {



        var $modal = $('#cloudonex_body');


        var sysrender = $('#application_ajaxrender');

        var _url = base_url;


        sysrender.on('click', '#mail_quote_created', function(e){
            e.preventDefault();
            var iid = $("#iid").val();
            $.fancybox.open({
                src  :  base_url + 'quotes/mail_invoice_/' + iid + '/created',
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



        sysrender.on('click', '#sms_quote_created', function(e){
            e.preventDefault();
            var iid = $("#iid").val();
            $.fancybox.open({
                src  :  base_url + 'quotes/sms_quote_/' + iid + '/created',
                type : 'ajax',
                opts : {
                    afterShow : function( instance, current ) {
                        $('#message').countSms('#sms-counter');
                    }
                },
            });




        });


        sysrender.on('click', '#sms_quote_accepted', function(e){
            e.preventDefault();
            var iid = $("#iid").val();
            $.fancybox.open({
                src  :  base_url + 'quotes/sms_quote_/' + iid + '/accepted',
                type : 'ajax',
                opts : {
                    afterShow : function( instance, current ) {
                        $('#message').countSms('#sms-counter');
                    }
                },
            });




        });


        sysrender.on('click', '#sms_quote_cancelled', function(e){
            e.preventDefault();
            var iid = $("#iid").val();
            $.fancybox.open({
                src  :  base_url + 'quotes/sms_quote_/' + iid + '/cancelled',
                type : 'ajax',
                opts : {
                    afterShow : function( instance, current ) {
                        $('#message').countSms('#sms-counter');
                    }
                },
            });




        });



        $modal.on('click', '#btnModalSMSSend', function(){



            $.post(base_url + 'sms/init/send_quote', {


                message: $('#message').val(),
                to: $("#sms_to").val(),
                from: $("#sms_from").val(),
                invoice_id: $("#smsQuoteId").val()

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

            $('#send').prop('disabled',true);

            $.post(base_url + 'quotes/send_email', $('#email_form').serialize()).done(function (data) {
                toastr.success(data);
            });

        });


        $("#convert_invoice").click(function (e) {
            e.preventDefault();


            bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                if(result){
                    $('#ibox').block({ message: null });
                    var iid = $("#iid").val();
                    $.post(  _url + "quotes/convert_invoice/", { iid: iid })
                        .done(function( data ) {
                            // console.log(data);
                            $('#ibox').unblock();


                            window.location = _url + 'invoices/view/' + data + '/';

                        });
                }
            });

        });


        $("#mark_draft").click(function (e) {
            e.preventDefault();


            bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                if(result){
                    var iid = $("#iid").val();
                    $.post(  _url + "quotes/mark_draft/", { iid: iid })
                        .done(function( data ) {
                            location.reload();
                        });
                }
            });

        });


        $("#mark_delivered").click(function (e) {
            e.preventDefault();


            bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                if(result){
                    var iid = $("#iid").val();
                    $.post(  _url + "quotes/mark_delivered/", { iid: iid })
                        .done(function( data ) {
                            location.reload();
                        });
                }
            });

        });

        $("#mark_on_hold").click(function (e) {
            e.preventDefault();
            bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                if(result){
                    var iid = $("#iid").val();
                    $.post(  _url + "quotes/mark_on_hold/", { iid: iid })
                        .done(function( data ) {
                            location.reload();
                        });
                }
            });

        });

        $("#mark_accepted").click(function (e) {
            e.preventDefault();
            bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                if(result){
                    var iid = $("#iid").val();
                    $.post(  _url + "quotes/mark_accepted/", { iid: iid })
                        .done(function( data ) {
                            location.reload();
                        });
                }
            });

        });

        $("#mark_lost").click(function (e) {
            e.preventDefault();
            bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                if(result){
                    var iid = $("#iid").val();
                    $.post(  _url + "quotes/mark_lost/", { iid: iid })
                        .done(function( data ) {
                            location.reload();
                        });
                }
            });

        });


        $("#mark_dead").click(function (e) {
            e.preventDefault();
            bootbox.confirm($("#_lan_msg_confirm").val(), function(result) {
                if(result){
                    var iid = $("#iid").val();
                    $.post(  _url + "quotes/mark_dead/", { iid: iid })
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
        })

    });
</script>

{/block}
