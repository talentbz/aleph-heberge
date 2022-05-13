{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Automation']}</h2>

                </div>
                <div class="panel-container">
                    <div class="panel-content">

                        <h4 class="mb-3">Create CRON Job for to run every minute (* * * * * )</h4>

                        <div class="hr-line-dashed"></div>

                        <div class="form-group">
                            <input id="cron_value" type="text" class="form-control form-control-lg" value="php {getcwd()}/system/cron.php >> /dev/null 2>&1">
                        </div>
                        <div class="form-group">
                            <label>Or,</label>
                            <input id="cron_value" type="text" class="form-control form-control-lg" value="curl --silent {APP_URL}/system/cron.php &>/dev/null">
                        </div>

                        <div class="form-group">
                            <label>{__('Alternative')} ({__('Daily')})</label>
                            <input id="cron_value" type="text" class="form-control form-control-lg" value="curl --silent {APP_URL}/system/cron_fallback_daily.php &>/dev/null">
                        </div>



                        <table class="table table-hover">
                            <tbody>



                            <tr>
                                <td width="80%">
                                    <label class="font-weight-bold" for="task_automatic_payment_reminder">{$_L['Enable Automatic Payment Reminder']}</label> <br>

                                </td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" class="clx_switch" id="task_automatic_payment_reminder" {if get_option('task_automatic_payment_reminder') eq '1'}checked{/if}>
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="80%">
                                    <label class="font-weight-bold" for="task_daily_accounting_snapshot">{$_L['Generate Daily Accounting Snapshot']}</label> <br>

                                </td>
                                <td>
                                    <label class="switch s-icons s-outline s-outline-primary">
                                        <input type="checkbox" class="clx_switch" id="task_daily_accounting_snapshot" {if get_option('task_daily_accounting_snapshot') eq '1'}checked{/if}>
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


                        <div class="form-group">
                            <label for="global_notifications_email">{$_L['Send Notifications To']}</label>
                            <input class="form-control" name="global_notifications_email" id="global_notifications_email" value="{get_or_default($config,'global_notifications_email')}">
                        </div>

                    </div>
{*                    <div class="panel-container">*}
{*                        <div class="panel-content">*}
{*                            <form method="post" action="{$_url}settings/automation-post/">*}

{*                                <div class="checkbox">*}
{*                                    <label>*}
{*                                        <input type="checkbox" class="sys_csw" name="accounting_snapshot" value="on" {if ($arcs['accounting_snapshot']) eq 'Active'}checked{/if}> {$_L['Generate Daily Accounting Snapshot']}*}
{*                                    </label>*}
{*                                </div>*}
{*                                <div class="checkbox">*}
{*                                    <label>*}
{*                                        <input type="checkbox" class="sys_csw" name="recurring_invoice" value="on" {if ($arcs['recurring_invoice']) eq 'Active'}checked{/if}> {$_L['Generate Recurring Invoices']}*}
{*                                    </label>*}
{*                                </div>*}
{*                                <div class="checkbox">*}
{*                                    <label>*}
{*                                        <input type="checkbox" class="sys_csw" name="notify" value="on" {if ($arcs['notify']) eq 'Active'}checked{/if}> {$_L['Enable Email Notifications']}*}
{*                                    </label>*}
{*                                </div>*}
{*                                <div class="form-group">*}
{*                                    <label for="exampleInputEmail1">{$_L['Send Notifications To']}: </label>*}
{*                                    <input type="email" class="form-control" id="notifyemail" name="notifyemail" value="{$arcs['notifyemail']}">*}
{*                                </div>*}
{*                                <hr>*}
{*                                <button type="submit" class="btn btn-success"><i class="fal fa-check"></i> {$_L['Save Changes']}</button>*}
{*                            </form>*}
{*                        </div>*}
{*                    </div>*}





                </div>
            </div>



        </div>



    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            $('.clx_switch').change(function() {

                let that = $(this);
                let value = 0;
                if(that.prop('checked')){

                    value = 1;

                }
                $.post( base_url+'settings/update_option/', { opt: that.attr('id'), val: value })
                    .done(function() {
                        location.reload();
                    });
            });

            $('#global_notifications_email').on('keyup paste',function () {
                let that = $(this);
                $.post( base_url+'settings/set-global-notification-email/', { email: that.val() });
            });
        });
    </script>
{/block}
