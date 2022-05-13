{extends file="$layouts_client"}

{block name="head"}

<style>
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #F7F9FC;
    }

    .h2, h2 {
        font-size: 1.25rem;
    }
    .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
        font-family: inherit;
        font-weight: 600;
        line-height: 1.5;
        margin-bottom: .5rem;
        color: #32325d;
    }
    .text-info{
        color: #6772E5!important;
    }
    .text-success{
        color: #2CCE89!important;
    }

</style>
{/block}

{block name="content"}

    <div class="row">
        <div class="col-md-4">
            <div class="panel">

                <div class="panel-container">
                    <div class="panel-content">
                        <div class="text-center">


                            {if $user['img'] eq ''}
                                <a href="javascript:;" onclick="upload_profile_picture();"><img src="{$app_url}ui/lib/img/default-user-avatar.png" class="img-circle" style="max-width: 128px;" alt="{$user->account}"></a>
                            {else}
                                <a href="javascript:;" onclick="upload_profile_picture();">
                                    <img src="{$app_url}{$user->img}" class="rounded-circle m-t-xs img-fluid avatar-xl mb-4" style="max-width: 128px;" alt="{$user->account}">
                                </a>
                            {/if}

                            <form enctype="multipart/form-data" method="post" action="{$_url}client/profile-picture-upload" id="form_profile_picture">
                                <input type="file" id="file_profile_picture" name="file" style="display: none;" />
                            </form>

                            <h3 style="margin-top: 20px; margin-bottom: 20px;"><span class="h2">{$user->account}</span></h3>

                            <strong>{$_L['Phone']}:</strong> {$user->phone}
                            <br>
                            <strong>{$_L['Email']}:</strong> {$user->email}

                            {if $config['show_business_number'] eq '1'}

                                <br>

                                <strong>{$config['label_business_number']}:</strong> {$user->business_number}

                            {/if}
                            <br>
                            <br>

                            <address>
                                {if $user->company neq ''}
                                    {$user->company}
                                    <br>
                                    {$user->account}
                                    <br>
                                {else}
                                    {$user->account}
                                    <br>
                                {/if}
                                {$user->address} <br>
                                {$user->city} <br>
                                {$user->state} - {$user->zip} <br>
                                {$user->country}
                                <br>


                                {foreach $cf as $cfs}
                                    <br>
                                    <strong>{$cfs['fieldname']}: </strong> {get_custom_field_value($cfs['id'],$user->id)}
                                {/foreach}

                            </address>


                            <a class="btn btn-warning" href="javascript:;" onclick="upload_profile_picture();">{$_L['Upload Picture']}</a>

                            {if $user['img'] neq ''}
                                <a class="btn btn-danger" href="{$_url}client/remove-profile-picture">{$_L['No Image']}</a>


                            {/if}

                            <br>

                             {if !empty($config['shipping_address'])}
                                 <a class="btn btn-warning mt-3" href="{$_url}client/shipping-addresses">{$_L['Shipping Addresses']}</a>
                             {/if}



                        </div>


                    </div>
                </div>


            </div>
        </div>
        <div class="col-md-8">
            <div class="panel">
                <div class="panel-hdr">

                    <h2><span class="h5">{$_L['Edit Profile']}</span></h2>

              </div>
                <div class="panel-container">
                    <div class="panel-content">


                        <form class="form-horizontal" id="iform">

                            <div class="form-group"><label  for="account"><span class="h6">{$_L['Account Name']}</span></label>

                                <input type="text" id="account" name="account" class="form-control" value="{$d['account']}">
                            </div>

                            <div class="form-group"><label  for="company"><span class="h6">{$_L['Company Name']}</span></label>

                                <input type="text" id="company" name="company" class="form-control" value="{$d['company']}">
                            </div>

                            <div class="form-group"><label  for="edit_email"><span class="h6">{$_L['Email']}</span></label>

                                <input type="text" id="edit_email" name="edit_email" class="form-control" value="{$d['email']}">
                            </div>
                            <div class="form-group"><label  for="phone"><span class="h6">{$_L['Phone']}</span></label>

                                <input type="text" id="phone" name="phone" class="form-control" value="{$d['phone']}">
                            </div>

                            {if $config['show_business_number'] eq '1'}

                                <div class="form-group">

                                    <label for="business_number"><span class="h6">{$config['label_business_number']}</span> </label>

                                    <input type="text" id="business_number" name="business_number" class="form-control" value="{$d['business_number']}">
                                </div>

                            {/if}

                            {if !isset($hide_client_address)}

                                <div class="form-group"><label  for="address"><span class="h6">{$_L['Address']}</span></label>

                                    <input type="text" id="address" name="address" class="form-control" value="{$d['address']}">
                                </div>
                                <div class="form-group"><label  for="city"><span class="h6">{$_L['City']}</span></label>

                                    <input type="text" id="city" name="city" class="form-control" value="{$d['city']}">
                                </div>
                                <div class="form-group"><label  for="state"><span class="h6">{$_L['State Region']}</span></label>

                                    <input type="text" id="state" name="state" class="form-control" value="{$d['state']}">
                                </div>
                                <div class="form-group"><label for="zip"><span class="h6">{$_L['ZIP Postal Code']}</span> </label>

                                    <input type="text" id="zip" name="zip" class="form-control" value="{$d['zip']}">
                                </div>
                                <div class="form-group"><label  for="country"><span class="h6">{$_L['Country']}</span></label>

                                    <select name="country" id="country" class="form-control">
                                        <option value="">{$_L['Select Country']}</option>
                                        {$countries}
                                    </select>
                                </div>

                            {/if}





                            <div class="form-group"><label  for="password"><span class="h6">{$_L['Password']} </span></label>

                                <input type="password" id="password" name="password" class="form-control">

                                <span class="help-block text-info">{$_L['password_change_help']}</span>

                            </div>



                            <div class="form-group">
                                <button class="btn btn-primary" type="submit" id="submit"> {$_L['Submit']}</button>
                            </div>

                        </form>


                    </div>
                </div>


            </div>
        </div>
    </div>
    <div class="row">

    <div class="col-md-4">

    <div class="panel">




    </div>
    </div>
    </div>

{/block}

{block name="script"}
    <script>

        var $file_profile_picture = $("#file_profile_picture");

        function upload_profile_picture()
        {
            $file_profile_picture.click();
        }

        $(function () {


            $file_profile_picture.change(function() {
                $('#form_profile_picture').submit();
            });


            var btn_form_action = $("#submit");


            var iform = $('#iform');


            var _url = $("#_url").val();

            btn_form_action.on('click', function(e) {
                e.preventDefault();
                iform.block({ message: block_msg });
                $.post( _url + "client/profile_edit_post/", iform.serialize())
                    .done(function (data) {
                        if ($.isNumeric(data)) {

                            location.reload();

                        }
                        else {



                            // OR

                            iform.unblock();


                            toastr.error(data)





                        }
                    });

            });

        });
    </script>
{/block}
