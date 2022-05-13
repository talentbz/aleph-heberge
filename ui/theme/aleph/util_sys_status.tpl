{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">

        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Application Environment']}</h2>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <table class="table table-bordered sys_table">
                            <tbody>



                            <tr>
                                <td>BASE URL</td>
                                <td>{$app_url}</td>
                            </tr>

                            <tr>
                                <td>Application Stage</td>
                                <td>{$app_stage}</td>
                            </tr>

                            <tr>
                                <td>Default Language</td>
                                <td>{$config['language']}</td>
                            </tr>


                            </tbody>
                        </table>
                    </div>



                </div>
            </div>
        </div>

        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Server Environment']}</h2>
{*                    <div class="panel-toolbar">*}
{*                        <a href="{$_url}util/sys_status_dl/" class="btn btn-primary"><i class="fal fa-download"></i> {$_L['Download']} </a>*}
{*                    </div>*}
                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        {$pinfo}
                    </div>




                </div>
            </div>
        </div>

    </div>
{/block}
