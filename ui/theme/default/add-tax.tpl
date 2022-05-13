{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-6">

            <div class="card">
                <div class="card-body">
                    <h5>{$_L['Add TAX']}</h5>

                    <form role="form" name="accadd" method="post" action="{$_url}settings/add-tax-post/">
                        <div class="form-group">
                            <label for="taxname">{$_L['Name']}</label>
                            <input type="text" class="form-control" id="taxname" name="taxname">
                        </div>
                        <div class="form-group">
                            <label for="taxrate">{$_L['Rate']}</label>
                            <input type="text" class="form-control" id="taxrate" name="taxrate">
                        </div>


                        <button type="submit" class="btn btn-primary"><i class="fal fa-check"></i> {$_L['Submit']}</button> | {$_L['Or']} <a href="{$_url}tax/list/"> {$_L['Back To The List']}</a>
                    </form>

                </div>
            </div>



        </div>



    </div>
{/block}
