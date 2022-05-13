{extends file="hostbilling/layouts/client.tpl"}


{block name="content"}

    <div class="card mx-auto" style="width: 800px">


        <div class="card-body">

            <h1 class="text-center"> {$_L['Articles']} </h1>

            {foreach $knowledgebases_group_relations as $key => $value}

                {if !empty($knowledgebases_groups[$key])}
                    <h2 class="my-3">{$knowledgebases_groups[$key]->gname}</h2>

                    {foreach $value as $kb_relation}
                        {if !empty($knowledgebases[$kb_relation->kbid])}
                            <p>
                                <a href="{$base_url}client/view-article/{$kb_relation->kbid}/"><strong>{$knowledgebases[$kb_relation->kbid]->title}</strong></a>
                            </p>
                        {/if}
                    {/foreach}

                {/if}

            {/foreach}





        </div>
    </div>


{/block}

