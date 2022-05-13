{extends file="$layouts_admin"}

{block name="content"}

    <h1>{$_L['Choose Server Type']}</h1>
    <div class="hr-line-dashed"></div>

    <div class="row">
        {foreach $available_server_types as $key => $value}
            <div class="col-md-3">
                <a href="{$base_url}hostbilling/server/0/{$key}">
                    <div class="card">
                        <div class="card-body">
                            <h2>{$value['name']}</h2>
                        </div>
                    </div>
                </a>
            </div>
        {/foreach}
    </div>



{/block}

{block name=script}

    <script>

    </script>


{/block}
