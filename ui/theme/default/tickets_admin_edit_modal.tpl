<div class="mx-auto" style="max-width: 600px;">
    <div class="panel rounded-0 mb-0">
        <div class="panel-hdr">
            <h2>{$_L['Edit']}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">

                <div class="form-group">
                    <textarea id="edit_content" class="form-control" name="content">{$ticket->message}</textarea>
                </div>

                <div class="form-group">
                    <input type="hidden" name="edit_type" value="{$type}" id="edit_type">
                    <input type="hidden" name="edit_tid" value="{$ticket->id}" id="edit_tid">
                    <button type="button" data-dismiss="modal" class="btn btn-danger">{$_L['Close']}</button>
                    <button class="btn btn-primary update_ticket_message" type="submit" id="update_ticket_message"><i class="fal fa-check"></i> {$_L['Save']}</button>
                </div>
            </div>
        </div>
    </div>
</div>
