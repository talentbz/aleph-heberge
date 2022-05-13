<div class="mx-auto" style="max-width: 400px;">
    <div class="panel mb-0 rounded-0">
        <div class="panel-hdr">
            <h2>{$_L['Send SMS']}</h2>
        </div>

        <div class="panel-container">
            <div class="panel-content">
                <form class="form-horizontal" id="ib_modal_form">

                    <input type="hidden" id="smsInvoiceId" name="smsInvoiceId" value="{$invoice_id}">

                    <div class="form-group"><label for="from">{$_L['From']}</label>
                        <input type="text" name="sms_from" id="sms_from" class="form-control " value="{$config['sms_sender_name']}">
                    </div>

                    <div class="form-group"><label for="sms_to">{$_L['To']} </label>
                        <input type="text" name="sms_to" id="sms_to" class="form-control " value="{$to}">
                    </div>

                    <div class="form-group"><label for="message">{$_L['SMS']} </label>
                        <textarea class="form-control" name="message" id="message" rows="4">{$message}</textarea>

                        <input type="hidden" name="template_id" id="template_id" value="">

                        <p class="help-block" id="sms-counter">
                            {$_L['Remaining']}: <span class="remaining"></span> | {$_L['Length']}: <span class="length"></span> | {$_L['Messages']}: <span class="messages"></span>
                        </p>
                    </div>

                    <button class="btn btn-primary modal_submit" type="submit" id="btnModalSMSSend">{$_L['Send']}</button>

                </form>
            </div>
        </div>

    </div>
</div>


