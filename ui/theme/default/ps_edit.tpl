<div class="mx-auto" style="max-width: 800px;">

    <div class="panel mb-0 rounded-0">

        <div class="panel-hdr ">

            <h2>{$_L['Edit']}</h2>
        </div>


        <div class="panel-container">
            <div class="panel-content">
                <div class="row">
                    <div class="col-md-8">
                        <form class="form-horizontal" role="form" id="edit_form" method="post">
                            <div class="form-group">
                                <label for="name">{$_L['Name']}</label>
                                <input type="text" class="form-control" value="{$item->name}" name="name" id="name">
                            </div>
                            <div class="form-group">
                                <label for="rate">{$_L['Item Number']}</label>
                                <input type="text" class="form-control" name="item_number" value="{$item->item_number}" id="item_number">
                            </div>
                            <div class="form-group">
                                <label for="rate" >{$_L['Sales Price']}</label>
                                <input type="text" id="sales_price" name="sales_price" class="form-control amount" autocomplete="off" data-a-sign="{$config['currency_code']}"  data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-d-group="2" value="{$item->sales_price}">
                            </div>

                            <div class="form-group">
                                <label for="cost_price" >{$_L['Cost Price']}</label>
                                <input type="text" id="cost_price" name="cost_price" class="form-control amount" autocomplete="off" data-a-sign="{$config['currency_code']}"  data-a-dec="{$config['dec_point']}" data-a-sep="{$config['thousands_sep']}" data-d-group="2" value="{$item->cost_price}">
                            </div>
                            <div class="form-group">
                                <label for="available" >{$_L['Available']}</label>
                                <input type="text" id="inventory" name="inventory" class="form-control" autocomplete="off" value="{round($item->inventory)}">
                            </div>

                            <div class="form-group">
                                <label for="description">{$_L['Description']}</label>
                                <textarea id="description" name="description" class="form-control" rows="3">{$item->description}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="sku">{$_L['SKU']}</label>
                                <input type="text" class="form-control" name="sku" value="{$item->sku}" id="sku">
                            </div>

                            <div class="form-group">
                                <label for="inventory">{$_L['Size']}</label>
                                <div class="col-sm-10">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <input type="text" id="width" name="width" placeholder="{$_L['Width']}" class="form-control" value="{$item->width}" autocomplete="off">
                                        </div>
                                        <div class="col-md-3">
                                            <input type="text" id="width" name="length" placeholder="{$_L['Length']}" class="form-control" value="{$item->length}" autocomplete="off">
                                        </div>
                                        <div class="col-md-3">
                                            <input type="text" id="width" name="height" placeholder="{$_L['Height']}" class="form-control" value="{$item->height}" autocomplete="off">
                                        </div>
                                        <div class="col-md-3">
                                            <input type="text" id="width" name="weight" placeholder="{$_L['Weight']}" class="form-control" value="{$item->weight}" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                            </div>






                            <input type="hidden" name="id" value="{$item->id}">
                            <input type="hidden" name="file_link" id="file_link_image" value="{$item->image}">
                            <button id="update" class="btn btn-primary">{$_L['Update']}</button>
                        </form>
                    </div>
                    <div class="col-md-4">
                        <form action="" class="dropzone" id="upload_container">

                            <div class="dz-message">
                                <h3> <i class="fal fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                                <br />
                                <span class="note">{$_L['Click to Upload']}</span>
                            </div>

                            <hr>



                        </form>

                        {$has_img}

                    </div>

                </div>
{*                <div class="row">*}
{*                    <div class="col-md-12">*}
{*                        <hr>*}

{*                        <div class="form-group">*}
{*                            <div class="input-group">*}
{*                                <div class="input-group-addon">{$_L['URL']}</div>*}
{*                                <input type="text" class="form-control" value="{U}item/{$item->id}/"  onClick="this.setSelectionRange(0, this.value.length)" id="item_url" readonly>*}
{*                                <div class="input-group-addon"><a href="javascript:void(0)" class="ib_btn_copy" data-clipboard-target="#item_url"><i class="fal fa-clipboard"></i> {$_L['Copy']}</a></div>*}
{*                            </div>*}
{*                        </div>*}

{*                        <div class="form-group">*}
{*                            <div class="input-group">*}
{*                                <div class="input-group-addon">{$_L['URL']} : {$_L['Add to Cart']}</div>*}
{*                                <input type="text" class="form-control" value="{U}cart/add/{$item->id}/"  onClick="this.setSelectionRange(0, this.value.length)" id="add_to_cart_url" readonly>*}
{*                                <div class="input-group-addon"><a href="javascript:void(0)" class="ib_btn_copy" data-clipboard-target="#add_to_cart_url"><i class="fal fa-clipboard"></i> {$_L['Copy']}</a></div>*}
{*                            </div>*}
{*                        </div>*}

{*                    </div>*}
{*                </div>*}

            </div>


        </div>
    </div>


</div>


