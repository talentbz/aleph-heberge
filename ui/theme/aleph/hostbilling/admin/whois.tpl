
{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel" >
                <div class="panel-container">
                    <div class="panel-content">

                        <div class="text-center">
                            <h3>{$_L['WHOIS Lookup']}</h3>
                            <div class="hr-line-dashed"></div>
                            <form class="form-inline" id="mainForm">

                                <div class="form-group">
                                    <input type="text" class="form-control" style="min-width: 600px;" name="domain" placeholder="Domain name...">
                                </div>

                                {csrf_field()}

                                <button type="submit" id="btnSubmit" class="btn btn-primary"><i class="fal fa-search"></i> </button>
                            </form>
                            <div class="hr-line-dashed"></div>
                        </div>


                    </div>

                    <div id="result"></div>

                </div>
            </div>
        </div>
    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            var $result = $('#result');
            var $btnSubmit = $('#btnSubmit');
            $('#mainForm').submit(function (event) {
                event.preventDefault();
                $btnSubmit.prop('disabled',true);
                $.post( "{$_url}hostbilling/admin/whois-lookup-post", $('#mainForm').serialize() ).done(function(data) {
                    $btnSubmit.prop('disabled',false);
                    $result.html('<div class="well">'+ data +'</div>');
                }).fail(function(data) {
                    spNotify(data.responseText,'error');
                    $btnSubmit.prop('disabled',false);
                });
            });

        })
    </script>
{/block}
