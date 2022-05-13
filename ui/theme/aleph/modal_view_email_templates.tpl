<div class="mx-auto" style="max-width: 800px;">
    <div class="panel mb-0 rounded-0">
        <div class="panel-hdr">
            <h2>{$_L['Email Templates']}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <table class="table table-bordered filter-table" id="tbl_email_templates">
                    <thead>
                    <tr>
                        <th>{$_L['Name']}</th>
                        <th width="60%">{$_L['Subject']}</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>

                    {foreach $tpls as $tpl}

                        <tr>

                            <td>{$tpl['tplname']}</td>
                            <td>{$tpl['subject']}</td>
                            <td><a href="#" class="btn btn-primary eml_select btn-icon" id="es{$tpl['id']}"><i class="fal fa-clone"></i> </a> </td>

                        </tr>

                    {/foreach}

                    </tbody>
                </table>



            </div>
        </div>
    </div>
</div>

