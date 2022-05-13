{extends file="$layouts_client"}



{block name="head"}


    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }

        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600!important;
            line-height: 1.5;
            margin-bottom: .5rem;
            color: #32325d;
        }
        .text-info{
            color: #6772E5!important;
        }
        .text-success{
            color: #2CCE89!important;}

        .text-danger{
            color: #F6365B!important;
        }
        .text-warning{
            color: #FB6340!important;
        }
        .text-primary{
            color: #10CDEF!important;
        }
    </style>
{/block}



{block name="content"}
    <div class="panel">
        <div class="panel-hdr">
            <h2>{$_L['Add Address']}</h2>
            <div class="panel-toolbar">

            <a href="{$_url}client/shipping-addresses" class="btn btn-sm btn-success"> {$_L['Shipping Addresses']}</a>
            </div>

        </div>
        <div class="panel-container">

        <div class="panel-content">

            <form id="main_form" method="post">

                <div class="form-group" >
                    <label  for="address"><span class="h6">{$_L['Address']}</span></label>

                    <input type="text" id="address1" name="address" class="form-control"
                           {if $shipping_address}
                           value="{{$shipping_address->address_line_1}}"
                    {/if}>
                </div>
                <div class="form-group"><label  for="city"><span class="h6">{$_L['City']}</span></label>

                    <input type="text" id="city" name="city" class="form-control"
                           {if $shipping_address}
                               value="{{$shipping_address->city}}"
                           {/if}>

                </div>
                <div class="form-group"><label  for="state"><span class="h6">{$_L['State Region']}</span></label>

                    <input type="text" id="state" name="state" class="form-control"
                            {if $shipping_address}
                                value="{{$shipping_address->state}}"
                            {/if}

                    >
                </div>
                <div class="form-group"><label for="zip"><span class="h6">{$_L['ZIP Postal Code']}</span> </label>

                    <input type="text" id="zip" name="zip" class="form-control"
                            {if $shipping_address}
                                value="{{$shipping_address->zip}}"
                            {/if}

                    >
                </div>
                <div class="form-group"><label  for="country"><span class="h6">{$_L['Country']}</span></label>

                    <select name="country" id="country" class="form-control">
                        <option value=""><span></span>{$_L['Select Country']}</option>
                        {$countries}

                    </select>



                </div>
                {if $shipping_address}

                    <input type="hidden" name="form_id" value="{{$shipping_address->id}}">

                {/if}
                <div class="form-group">
                    <button type="submit" class="btn btn-primary" id="btn_submit">Submit</button>

                </div>






            </form>




        
        
        
        
        </div>
        </div>

        
     

    </div>




    

{/block}


{block name=script}

    <script>

        $(function () {

            $('#success_message').redactor(
                {
                    minHeight: 200 // pixels
                }
            );

            let $main_form = $('#main_form');
            let $btn_submit = $('#btn_submit');

            var form = document.getElementById("main_form");
            var pristine = new Pristine(form);

            $main_form.on('submit',function (e) {
                e.preventDefault();


                if(pristine.validate())
                {
                    $btn_submit.prop('disabled',true);

                    $.post( base_url + 'client/save-shipping-address', $main_form.serialize())
                        .done(function( data ) {

                           window.location = base_url + 'client/shipping-addresses';

                        }).fail(function (error) {
                        $btn_submit.prop('disabled',false);
                        toastr.error(error.responseText);
                    });
                }






            });
            $country = $("#country");

            $country.select2();

        });

    </script>


{/block}




