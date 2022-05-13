{if !empty($result->domainName)}
    <h1 class="mb-3">{$result->domainName}</h1>
{/if}

<h4>Registration Details</h4>
<div class="hr-line-dashed mt-0"></div>
{if !empty($result->creationDate)}
    <div class="mb-2">
        <strong>{__('Registered at')}:</strong> {date($config['df'],$result->creationDate)}
    </div>

{/if}

{if !empty($result->expirationDate)}
    <div class="mb-2">
        <strong>{__('Expiration date')}:</strong> {date($config['df'],$result->expirationDate)}
    </div>

{/if}


{if !empty($result->owner)}
    <div class="mb-2">
        <strong>{__('Owner')}:</strong> {$result->owner}
    </div>
{/if}

{if !empty($result->registrar)}
    <div class="mb-2">
        <strong>{__('Registrar')}:</strong> {$result->registrar}
    </div>
{/if}

{if !empty($result->nameServers)}

    <h4 class="mt-3">{__('Nameservers')}</h4>
    <div class="hr-line-dashed mt-0"></div>

    {foreach $result->nameServers as $name_server}
        <div class="mb-2">
            <strong>{$name_server}</strong>
        </div>
    {/foreach}

{/if}

