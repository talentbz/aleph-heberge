{if $available}
    <h3>{$_L['Congratulation']}<mark>{$domain_name_full}</mark>
        {$_L['is available']}.</h3>

    <form method="post" action="{$base_url}client/buy-now-domain/">

        <input type="hidden" name="extension" value="{$extension}">
        <input type="hidden" name="domain_name" value="{$domain_name}">

        <div class="my-3">
            <select class="custom-select" name="term">
                <option value="1">1 {__('year')} - {formatCurrency($domain_price->register,$config['home_currency'])}</option>
                {for $i=2; $i <= 10; $i++}
                    <option value="{$i}">{$i} {__('years')} - {formatCurrency($domain_price->register*$i,$config['home_currency'])}</option>
                {/for}
            </select>
        </div>
        <button type="submit" class="btn btn-primary domain_buy_now"> {$_L['Buy Now']}</button>
    </form>

    {else}
    <h3 class="text-muted mb-0">{$domain_name_full} {$_L['is not available, try another domain']}</h3>
{/if}
