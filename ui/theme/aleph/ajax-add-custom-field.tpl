<div class="mx-auto">
    <div class="panel mb-0 rounded-0" id="modal_form">
        <div class="panel-hdr">
            <h2>
                {$_L['Add Custom Field']}
            </h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <form role="form" name="add_form" id="add_form" method="post" action="{$_url}settings/customfields-post">
                    <div class="form-group">
                        <label for="fieldname">{$_L['Field Name']}</label>
                        <input type="text" class="form-control" id="fieldname" name="fieldname">
                    </div>

                    <div class="form-group">
                        <label for="fieldtype">{$_L['Field Type']}</label>
                        <select class="form-control" name="fieldtype" id="fieldtype">

                            <option value="text" selected="">{$_L['Text Box']}</option>
                            <option value="password">{$_L['Password']}</option>
                            <option value="dropdown">{$_L['Drop Down']}</option>
                            <option value="textarea">{$_L['Text Area']}</option>

                        </select>
                    </div>
                    <div class="form-group">
                        <label for="description">{$_L['Description']}</label>
                        <input type="text" class="form-control" id="description" name="description">
                        <span class="help-block">{$_L['Optional Description help']}</span>
                    </div>
                    <div class="form-group">
                        <label for="validation">{$_L['Validation']}</label>
                        <input type="text" class="form-control" id="validation" name="validation">
                        <span class="help-block">{$_L['Regular Expression Validation']}</span>
                    </div>
                    <div class="form-group">
                        <label for="options">{$_L['Select Options']}</label>
                        <input type="text" class="form-control" id="options" name="options">
                        <span class="help-block">{$_L['Comma Separated List']}</span>
                    </div>

                    <div class="form-group">
                        <label for="options">{$_L['Show in View Invoice']}</label>
                        <div class="radio">
                            <label>
                                <input type="radio" name="showinvoice" id="showInvoiceYes" value="Yes">
                                {$_L['Yes']}
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="showinvoice" id="showInvoiceNo" value="No" checked>
                                {$_L['No']}
                            </label>
                        </div>

                    </div>

                    <div class="form-group">
                        <button type="button" class="btn btn-primary" id="add_submit">{$_L['Save']}</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
