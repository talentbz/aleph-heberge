<div class="mx-auto" style="max-width: 800px;">

    <div class="panel mb-0 rounded-0">
        <div class="panel-hdr">
            <h2>{$_L['Add New Contact']}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <form class="form-horizontal" id="rform">

                    <div class="form-group"><label for="account">{$_L['Full Name']}</label>
                        <input type="text" id="account" name="account" class="form-control" >
                    </div>

                    <div class="form-group"><label for="company">{$_L['Company Name']}</label>

                        <input type="text" id="company" name="company" class="form-control">
                    </div>

                    <div class="form-group"><label for="email">{$_L['Email']}</label>

                        <input type="text" id="email" name="email" class="form-control" >

                    </div>
                    <div class="form-group"><label for="phone">{$_L['Phone']}</label>

                        <input type="text" id="phone" name="phone" class="form-control" >
                    </div>
                    <div class="form-group"><label for="m_address">{$_L['Address']}</label>

                        <input type="text" id="m_address" name="m_address" class="form-control" >
                    </div>
                    <div class="form-group"><label for="city">{$_L['City']}</label>

                        <input type="text" id="city" name="city" class="form-control" >
                    </div>
                    <div class="form-group"><label for="state">{$_L['State Region']}</label>

                        <input type="text" id="state" name="state" class="form-control" >
                    </div>
                    <div class="form-group"><label for="zip">{$_L['ZIP Postal Code']} </label>

                        <input type="text" id="zip" name="zip" class="form-control" >
                    </div>
                    <div class="form-group"><label for="country">{$_L['Country']}</label>

                        <select name="country" class="country" id="country" class="form-control">
                            <option value="">{$_L['Select Country']}</option>
                            {$countries}
                        </select>
                    </div>


                    <div class="form-group">
                        <button class="btn btn-primary contact_submit" type="submit" id="contact_submit"><i class="fal fa-check"></i> {$_L['Add Contact']}</button>
                    </div>


                </form>
            </div>
        </div>
    </div>
</div>






