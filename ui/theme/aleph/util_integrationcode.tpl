{extends file="$layouts_admin"}

{block name="head"}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.20.0/themes/prism.min.css" />
{/block}

{block name="content"}
    <div class="row">

        <div class="col-md-8 col-xs-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Integration Code']}</h2>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <h4>{$_L['Client Login']}</h4>
                        <pre><code class="language-html">{$form_client_login}</code></pre>
                        <h4>{$_L['Client Registration']}</h4>
                        <pre><code class="language-html">{$form_client_register}</code></pre>
                    </div>


                </div>
            </div>
        </div>



    </div>
{/block}

{block name="script"}
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.20.0/prism.min.js"></script>

    <script>
        $(function () {

        });
    </script>

{/block}
