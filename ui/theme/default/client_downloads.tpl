{extends file="$layouts_client"}

{block name="content"}


    <div class="row">
        <div class="col-md-12">

            <div class="card border" id="t_options">

                <div class="card-header">
                    <ul class="nav nav-tabs card-header-tabs">
                        <li class="nav-item active"><a class="nav-link active" href="{$_url}client/downloads"><i class="fal fa-th"></i> {$_L['Downloads']}</a></li>
                        <li class="nav-item"><a class="nav-link" href="{$_url}client/uploads"><i class="fal fa-tasks"></i> {$_L['Uploads']}</a></li>
                    </ul>
                </div>




                <div class="card-body">




                    <div class="tab-content">
                        <div id="details" class="tab-pane fade show active ib-tab-box">


                            <div class="row">
                                <div class="col-lg-12">

                                    {if count($d) > 0}

                                        {foreach $d as $ds}

                                            <div class="file-box">
                                                <div class="file">
                                                    <a href="{$_url}client/dl/{$ds['id']}_{$ds['file_dl_token']}/">
                                                        <span class="corner"></span>

                                                        <div class="icon">
                                                            {if $ds['file_mime_type'] eq 'jpg' || $ds['file_mime_type'] eq 'png' || $ds['file_mime_type'] eq 'gif'}
                                                                <i class="fal fa-file-image-o"></i>
                                                            {elseif $ds['file_mime_type'] eq 'pdf'}
                                                                <i class="fal fa-file-pdf-o"></i>
                                                            {elseif $ds['file_mime_type'] eq 'zip'}
                                                                <i class="fal fa-file-archive-o"></i>
                                                            {else}
                                                                <i class="fal fa-file"></i>
                                                            {/if}
                                                        </div>
                                                        <div class="file-name">
                                                            {$ds['title']}
                                                            <br/>
                                                            <small>
                                                                {if (isset($ds['updated_at']) && ($ds['updated_at']) != '')}
                                                                    {date( $config['df'], strtotime($ds['updated_at']))}
                                                                {else}
                                                                    {date( $config['df'], strtotime($ds['created_at']))}
                                                                {/if}

                                                            </small>
                                                        </div>
                                                    </a>
                                                </div>

                                            </div>

                                        {/foreach}

                                    {else}
                                        {$_L['No Data Available']}
                                    {/if}






                                </div>
                            </div>

                        </div>



                    </div>





                </div>

            </div>



        </div>
    </div>





{/block}
