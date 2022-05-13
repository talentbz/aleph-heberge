{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-6">
            <div class="card">

                <div class="card-body">
                    <h5 class="mb-3">{$_L['Change Password']}</h5>
                    <form role="form" name="accadd" method="post" action="{$_url}settings/change-password-post">
                        <div class="form-group">
                            <label for="password">{$_L['Current Password']}</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        <div class="form-group">
                            <label for="npass">{$_L['New Password']}</label>
                            <input type="password" class="form-control" id="npass" name="npass">
                        </div>
                        <div class="form-group">
                            <label for="cnpass">{$_L['Confirm New Password']}</label>
                            <input type="password" class="form-control" id="cnpass" name="cnpass">
                        </div>




                        <button type="submit" class="btn btn-primary"><i class="fal fa-check"></i> {$_L['Submit']}</button>
                    </form>

                </div>
            </div>



        </div>



    </div>
{/block}

