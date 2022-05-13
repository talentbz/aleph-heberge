{extends file="$layouts_admin"}

{block name="content"}


    <div class="row">



        <div class="col-md-12">



            <div class="panel">

                <div class="panel-hdr">
                    <h2>Currencies</h2>
                    <div class="panel-toolbar">

                        <a href="#" class="btn btn-success" id="add_currency"><i class="fal fa-plus"></i> {$_L['New Currency']}</a>


                    </div>
                </div>

                <div class="panel-container">

                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th class="bold">{$_L['Currency Code']}</th>
                                    {*<th class="bold">{$_L['Currency Symbol']}</th>*}
                                    <th class="bold">{$_L['Base Conversion Rate']}</th>
                                    <th class="text-center bold">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>


                                {foreach $currencies as $currency}
                                    <tr data-id="{$currency['id']}">
                                        <td> <a class="cedit" id="ae{$currency['id']}" href="#">{$currency['cname']}</a>
                                            {if $config['home_currency'] == $currency['cname']}
                                                <br>
                                                {$_L['Base Currency']}
                                            {/if}
                                        </td>
                                        {*<td>{$currency['symbol']}</td>*}
                                        <td>{$currency['rate']}</td>
                                        <td class="text-right">
                                            <a href="{$_url}" id="be{$currency['id']}" class="btn btn-primary cedit" data-toggle="tooltip" title="{$_L['Edit']}"><i class="fal fa-pencil"></i> </a>
                                            {if $config['home_currency'] != $currency['cname']}
                                                <a href="{$_url}settings/make_base_currency/{$currency['id']}/" class="btn btn-primary" data-toggle="tooltip" title="{$_L['Make Base Currency']}"><i class="fal fa-star"></i> </a>
                                            {/if}

                                            <a href="#" class="btn btn-danger cdelete" id="c{$currency['id']}" data-toggle="tooltip" title="{$_L['Delete']}"><i class="fal fa-trash-alt"></i> </a>
                                        </td>

                                    </tr>
                                {/foreach}






                                </tbody>
                            </table>
                        </div>
                    </div>





                </div>
            </div>
        </div>



    </div>
{/block}

{block name="script"}
    <script>
        $(function() {

            var $modal = $('#cloudonex_body');

            $('[data-toggle="tooltip"]').tooltip();

            var _url = $("#_url").val();

            $('#add_currency').on('click', function(e){

                e.preventDefault();


                $.fancybox.open({
                    src  :  base_url + 'settings/modal_add_currency/',
                    type : 'ajax',
                    opts : {

                    },
                });





            });


            $modal.on('change','.currencyCode',function () {
                $('#selectedCurrency').html("1" + $('#iso_code').val());
            });


            $modal.on('click', '.modal_submit', function(e){

                e.preventDefault();


                $.post( base_url + "settings/add_currency_post/", $("#ib_modal_form").serialize())
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {

                            toastr.error(data);
                        }

                    });

            });


            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/currency/" + id + '/';
                    }
                });
            });


            $(".cedit").click(function (e) {
                e.preventDefault();
                var id = this.id;

                $.fancybox.open({
                    src  :  base_url + 'settings/modal_add_currency/'+ id + '/',
                    type : 'ajax',
                    opts : {

                    },
                });


            });





        });
    </script>
{/block}
