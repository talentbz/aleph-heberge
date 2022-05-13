{extends file="$layouts_admin"}

{block name="content"}
    <div class="row animated fadeInDown">
        <div class="col-lg-12"  id="application_ajaxrender">
            <div class="panel">
                <div class="panel-hdr">
                    <h2> {$d['subject']} </h2>

                    <div class="panel-toolbar">
                        <a href="{$_url}util/sent-emails" class="btn btn-primary btn-sm"><i class="fal fa-mail-reply-all"></i> {$_L['Back To Emails']}</a>
                    </div>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        {$d['message']}
                    </div>



                </div>


            </div>
        </div>
    </div>
{/block}
