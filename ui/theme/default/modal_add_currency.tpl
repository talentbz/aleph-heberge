<div class="mx-auto" style="max-width: 400px;">
    <div class="panel mb-0 rounded-0">
        <div class="panel-container">
            <div class="panel-hdr">
                <h2>
                    {if $f_type eq 'edit'}
                        {$_L['Edit']}
                    {else}
                        {$_L['New Currency']}
                    {/if}
                </h2>
            </div>
            <div class="panel-content">
                <form class="form-horizontal" id="ib_modal_form">

                    <div class="form-group"><label for="iso_code">{$_L['Currency_Code']}</label>

                        <input type="text" id="iso_code" name="iso_code" class="form-control currencyCode" value="{$val['code']}">
                        <span class="help-block">{$_L['Currency Example']}</span>


                    </div>



                    <div class="form-group"><label for="rate">{$_L['Base Conversion Rate']}</label>

                        <input type="text" id="rate" name="rate" class="form-control" value="{$val['rate']}" >

                        <span class="help-block">Enter the value of <strong id="selectedCurrency">1 {$val['code']}</strong> = How much {if isset($home_currency->iso_code)} {$home_currency->iso_code} {/if}?</span>
                    </div>

                    <input type="hidden" name="f_type" id="f_type" value="{$f_type}">
                    <input type="hidden" name="cid" id="cid" value="{$val['cid']}">

                    <div class="form-group">
                        <button class="btn btn-primary modal_submit" type="submit" id="modal_submit"><i class="fal fa-check"></i> {$_L['Save']}</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

