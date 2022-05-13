{extends file="$layouts_client"}
{if isset($include)}
    {include file="../../../$_pd/views/$include.tpl"}
{elseif isset($_include)}
    {include file="../../../$_pd/views/$_include.tpl"}
{/if}
