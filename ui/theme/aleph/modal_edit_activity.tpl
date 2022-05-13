<div style="max-width: 800px;" class="mx-auto">
    <div class="panel mb-0 rounded-0">
        <div class="panel-hdr">
            <h2>{$_L['Edit']}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <section class="activity-post mb-xlg">
                    <form method="get" action="/" id="ib_modal_edit_activity_form">
                        <textarea name="message_text" id="edit_activity_message" class="edit_activity"  data-plugin-textarea-autosize="" placeholder="{$_L['Add Activity']}..." rows="1" style="overflow: hidden; word-wrap: break-word; resize: none; height: 200px;">{$d->msg}</textarea>
                        <input type="hidden" id="edit_activity_type" name="edit_activity_type" value="{$d->icon}">
                        <input type="hidden" id="edit_activity_id" name="edit_activity_id" value="{$d->id}">


                    </form>
                    <div class="compose-box-footer">
                        <ul class="compose-toolbar">
                            <li class="clickable {if $d->icon eq 'fal fa-envelope'}action-active{/if}"><a href="#"><i class="fal fa-envelope"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-phone'}action-active{/if}"><a href="#"><i class="fal fa-phone"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-paper-plane'}action-active{/if}"><a href="#"><i class="fal fa-paper-plane"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-file-pdf'}action-active{/if}"><a href="#"><i class="fal fa-file-pdf"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-life-ring'}action-active{/if}"><a href="#"><i class="fal fa-life-ring"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-credit-card'}action-active{/if}"><a href="#"><i class="fal fa-credit-card"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-location-arrow'}action-active{/if}"><a href="#"><i class="fal fa-location-arrow"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-reply'}action-active{/if}"><a href="#"><i class="fal fa-reply"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-tasks'}action-active{/if}"><a href="#"><i class="fal fa-tasks"></i></a></li>
                            <li class="clickable {if $d->icon eq 'fal fa-truck'}action-active{/if}"><a href="#"><i class="fal fa-truck"></i></a></li>
                        </ul>

                    </div>
                </section>

                <div class="form-group mt-3">
                    <button class="btn btn-primary modal_activity_submit" type="submit" id="modal_activity_submit"><i class="fal fa-check"></i> {$_L['Save']}</button>
                </div>

            </div>
        </div>
    </div>
</div>



