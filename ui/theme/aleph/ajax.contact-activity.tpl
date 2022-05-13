<section class="activity-post mb-xlg">
    <form method="get" action="/">
        <textarea name="message-text" class="form-control" id="msg" data-plugin-textarea-autosize="" placeholder="{$_L['Add Activity']}..." rows="1" style="overflow: hidden; word-wrap: break-word; resize: none; height: 200px;"></textarea>
        <input type="hidden" id="activity-type" value="">

    </form>
    <div class="compose-box-footer">
        <ul class="compose-toolbar">
            <li class="clickable"><a href="#"><i class="fal fa-envelope"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-phone"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-paper-plane"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-file-pdf"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-life-ring"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-credit-card"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-location-arrow"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-reply"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-tasks"></i></a></li>
            <li class="clickable"><a href="#"><i class="fal fa-truck"></i></a></li>
        </ul>
        <ul class="compose-btn">
            <li>

                <a class="btn btn-primary btn-sm" href="#" id="acf-post"><i class="fal fa-arrow-right"></i> {$_L['Post']}</a>
            </li>
        </ul>
    </div>
</section>
<div class="mt-3"> </div>
{foreach $ac as $acs}
    <div class="timeline-item">
        <div class="row">
            <div class="col-sm-3 col-md-2 date">
                <i class="{str_replace('fa fa-','fal fa-',$acs['icon'])}"></i>
                <span class="sdate">{date( $config['df'], $acs['stime'])}</span>
                <br>
                <small class="text-navy"><span class="mmnt">{$acs['stime']}</span></small>
            </div>
            <div class="col-sm-9 col-md-10 content no-top-border">
                <p class="m-b-xs"><strong>{$acs['oname']}</strong></p>

                <p>{$acs['msg']}</p>
                <p>
                    <a href="#" class="btn btn-info btn-xs activity_edit" id="activity_{$acs['id']}"><i class="fal fa-pencil"></i> {$_L['Edit']}</a>
                    <a href="{$_url}contacts/activity-delete/{$acs['cid']}/{$acs['id']}" class="btn btn-danger btn-xs"><i class="fal fa-trash"></i> {$_L['Delete']}</a>
                </p>

            </div>
        </div>
    </div>
{/foreach}
