{extends file="$layouts_admin"}


{block name="content"}

    <div style="max-width: 1000px; width: 100%;" class="mx-auto">
        <div class="panel">
            <div class="panel-hdr">
                <h2>{$lead_form->name}</h2>

            </div>
            <div class="panel-container">
                <div class="panel-content">

                    <div class="form-group">
                        <label for="direct_link">{$_L['Direct Link']}</label>
                        <input type="text" class="form-control mb-3" id="direct_link" onClick="this.setSelectionRange(0, this.value.length)" value="{$_url}client/form/{$lead_form->uuid}">
                    </div>

                    <h3>{$_L['Embed']}</h3>

                    <div class="panel-tag">
                        <textarea class="form-control" onClick="this.setSelectionRange(0, this.value.length)" rows="10">{{$embed_code}}</textarea>
                    </div>



                </div>
            </div>
        </div>
    </div>

{/block}

{block name=script}

    <script>

        $(function () {



        });

    </script>

{/block}
