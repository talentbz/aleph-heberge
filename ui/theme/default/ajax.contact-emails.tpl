<div class="mail-box">


    <div class="mail-body">

        <form class="form-horizontal" method="get">
            <div class="form-group"><label>{$_L['To']}:</label>

                <input type="text" id="toemail" name="toemail" class="form-control" value="{$d['email']}" disabled>
            </div>
            <div class="form-group"><label>{$_L['Subject']}:</label>

                <input type="text" id="subject" name="subject" class="form-control" value="">
            </div>
        </form>

    </div>

    <div class="mail-text mt-3">

        <div class="form-group">
            <textarea id="content"  class="form-control sysedit" name="content"></textarea>
        </div>

        <div class="clearfix"></div>
    </div>

    <div class="mail-body mb-3">
        <div class="row">
            <div class="col-md-10">
                <a href="#" class="choose_from_template" id="choose_from_template"><i class="fal fa-file-alt"></i> {$_L['Choose from Template']}</a>
            </div>
            <div class="col-md-2 text-right">
                <button type="submit" id="send_email"  class="btn btn-sm btn-primary"><i class="fal fa-paper-plane-o"></i> {$_L['Send']}</button>
            </div>
        </div>

    </div>
    <div class="clearfix"></div>



</div>

<table class="table table-bordered table-hover sys_table">
    <thead>
    <tr>


        <th width="80%">{$_L['Subject']}</th>
        <th>{$_L['Date']}</th>

    </tr>
    </thead>
    <tbody>

    {foreach $e as $is}
        <tr>


            <td>{$is['subject']}</td>
            <td>{$is['date']}</td>

        </tr>
    {/foreach}

    </tbody>
</table>
