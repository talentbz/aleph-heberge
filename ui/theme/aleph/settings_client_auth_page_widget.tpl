<div style="max-width: 800px;" class="mx-auto">
    <div class="panel mb-0 rounded-0">
        <div class="panel-hdr">
            <h2>{$_L['Edit']}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <form id="clx_modal_form">
                    <div class="form-group">
                        <textarea id="edit_content" name="content" class="form-control">{Widget::getWidgetContent('client-auth-page-widget')}</textarea>
                    </div>
                    <div class="form-group">
                        <button type="button" id="btn_save_content" class="btn btn-primary modal_submit">{$_L['Save']}</button>
                        <button type="button" class="btn btn-danger" onclick="$.fancybox.close();">{$_L['Cancel']}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
