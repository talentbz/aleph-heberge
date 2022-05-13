{extends file="hostbilling/layouts/client.tpl"}

{block name="content"}



    <div class="container">

        <h1 class="text-center my-3">{$_L['Products n Services']}</h1>

        <div class="row">
            {foreach $groups as $group}

                <div class="col-md-3 col-xs">
                    <a href="{$base_url}client/items/{$group->slug}/" class="m-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h3>{$group->name}</h3>
                            </div>
                        </div>
                    </a>
                </div>

            {/foreach}
        </div>

        <div class="row justify-content-center">
            <div class="col-md-3">
                <a href="{$base_url}client/whois/" class="m-3">
                    <div class="card">
                        <div class="card-body">

                            <div class="text-center">
                                <img style="max-width: 120px;" src="{APP_URL}/ui/theme/default/hostbilling/img/whois.png">
                                <h3 class="mt-3">{$_L['WHOIS Lookup']}</h3>
                            </div>

                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-3">
                <a href="{$base_url}client/kb/" class="m-3">
                    <div class="card">
                        <div class="card-body">

                            <div class="text-center">
                                <img style="max-width: 120px;" src="{APP_URL}/ui/theme/default/hostbilling/img/file.png">
                                <h3 class="mt-3">{$_L['Knowledgebase']}</h3>
                            </div>

                        </div>
                    </div>
                </a>
            </div>


        </div>





    </div>




{/block}

{block name=script}

    <script>

    </script>


{/block}
