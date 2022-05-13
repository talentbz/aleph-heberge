<div class="mx-auto" style="max-width: 600px;">
    <div class="panel mb-0 rounded-0">
        <div class="panel-hdr">
            <h2>{$client->account}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                {$client->email} <br>

                {if $client->phone}
                    {$client->phone} <br>
                {/if}

                <div class="hr-line-dashed"></div>

                {if $client->address}
                    {$client->address} <br>
                    {$client->city} <br>
                    {$client->state} - {$client->zip} <br>
                    {$client->country}
                {/if}


            </div>
        </div>
    </div>
</div>
