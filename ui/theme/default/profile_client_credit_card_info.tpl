
{block name="head"}

    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }
        .form-primary .form-control {
            color: #fff;
            border-color: #324cdd;
            background-color: rgba(50,76,221,.5);
        }
        .form-primary .input-group-text {
            color: #fff;
            border-color: #324cdd;
            background-color: rgba(50,76,221,.5);
        }

        .form-control:focus {
            color: #8898aa;
            border-color: #3E54DF;
            outline: 0;
            background-color: #3E50DE;
            box-shadow: 0 3px 9px rgba(50,50,9,0), 3px 4px 8px rgba(94,114,228,.1);
        }
        .has-length .input-group-text:not([class^="bg-"]):not([class*=" bg-"]) {
            background:#3E50DE;
            color: #fff !important;
        }
        .input-group>.form-control:not(:first-child) {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
        .focused .form-control {
            border-color: #484e73;
        }
        .form-control::placeholder {
            color: #ffffff;
            opacity: 1;
        }
        .card-serial-number {
            font-size: 1.625rem;
            display: flex;
            justify-content: space-between;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600;
            line-height: 1.5;
            margin-bottom: .5rem;
            color: #32325d;
        }
        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            border: 1px solid rgba(0,0,0,.05);
            border-radius: .375rem;
            background-color: #fff;
            background-clip: border-box;
        }
        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            border: 1px solid rgba(0,0,0,.05);
            border-radius: .375rem;
            background-color: #fff;
            background-clip: border-box;
        }
        .card-body {
            min-height: 1px;
            padding: 1.5rem;
            flex: 1 1 auto;
        }
        .justify-content-between {
            justify-content: space-between!important;
        }
        .align-items-center {
            align-items: center!important;
        }
        .row {
            display: flex;
            margin-right: -15px;
            margin-left: -15px;
            flex-wrap: wrap;
        }
        .text-light {
            color: #ced4da!important;
        }
        .h6, h6 {
            font-size: .625rem;
        }

    </style>
{/block}

{block name="content"}

    <div class="row">
        <div cllass="col">
            <div class="panel-container">
                <div class="panel-content">
                    <div style="background: linear-gradient(87deg,#5e72e4 0,#825ee4 100%)!important;">
                        <!-- Card body -->
                        <div class="card-body">
                            <div class="row justify-content-between align-items-center">
                                {*                <div class="col">*}
                                {*                    <img src="../assets/img/icons/cards/mastercard.png" alt="Image placeholder" />*}
                                {*                </div>*}
                                {*                <div class="col-auto">*}
                                {*                    <div class="d-flex align-items-center">*}
                                {*                        <small class="text-white font-weight-bold mr-3">Make default</small>*}
                                {*                        <div>*}
                                {*                            <label class="custom-toggle  custom-toggle-white">*}
                                {*                                <input type="checkbox" checked="">*}
                                {*                                <span class="custom-toggle-slider rounded-circle" data-label-off="No" data-label-on="Yes"></span>*}
                                {*                            </label>*}
                                {*                        </div>*}
                                {*                    </div>*}
                                {*                </div>*}
                            </div>
                            <div class="mt-4">

                                <form role="form" id="credit_card_from" class="form-primary">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="input-group input-group-alternative mb-3">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fal fa-user "></i></span>
                                                    </div>
                                                    <input class="form-control" name="card-holder-name" id="card-holder-name" placeholder="Name on card" type="text">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="input-group input-group-alternative mb-3">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fal fa-credit-card"></i></span>
                                                    </div>
                                                    <input class="form-control" name="card-number" placeholder="Card number" type="text">
                                                </div>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <div class="input-group input-group-alternative mb-3">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fal fa-calendar"></i></span>
                                                    </div>
                                                    <input class="form-control" name="expiry-month" placeholder="MM" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-group">
                                                <div class="input-group input-group-alternative mb-3">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fal fa-calendar"></i></span>
                                                    </div>
                                                    <input class="form-control" name="expiry-year" placeholder="YY" type="text">
                                                </div>
                                            </div>
                                        </div>



                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group">
                                                <div class="input-group input-group-alternative">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fal fa-lock"></i></span>
                                                    </div>
                                                    <input class="form-control" name="cvv" id="cvv" placeholder="CCV" type="text">
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <input type="hidden" name="contact_id" value="{$contact->id}">
                                    <button type="button" id="save_credit_card" class="btn btn-block btn-info mt-3">Save new card</button>
                                </form>
                            </div>
                        </div>







                    </div>
                </div>

            </div>
        </div>


    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="panel-container">
                <div class="panel-content">





                    <div class="card" style="background: linear-gradient(90deg, rgba(136,82,235,1) 0%, rgba(30,7,56,1) 0%, rgba(26,9,102,1) 100%, rgba(15,215,117,1) 100%);">
                        <!-- Card body -->

                        {if $credit_card}

                            <div class=" card-body">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col text-success">
                                        ccv {$credit_card->cvv}
{*                                        <img src="../assets/img/icons/cards/visa.png" alt="Image placeholder" />*}
                                    </div>
                                    <div class="col-auto">
                                        <span class="badge badge-lg badge-success">Active</span>
                                    </div>
                                </div>
                                <div class="my-4">
                <span class="h6 surtitle text-light">
                  CARD NUMBER
                </span>
                                    <div class="card-serial-number h1 text-white">


                                        <div>{$credit_card->card_number}</div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <span class="h6 surtitle text-light">NAME</span>
                                        <span class="d-block h3 text-white">{$credit_card->card_holder_name}</span>
                                    </div>
                                    <div class="col">
                                        <span class="h6 surtitle text-light">EXPIRY DATE</span>
                                        <span class="d-block h3 text-white">{$credit_card->expiry_month}/{$credit_card->expiry_year}</span>
                                    </div>
                                </div>
                            </div>

                        {/if}

                    </div>
                </div>


            </div>
        </div>
    </div>




{/block}
{block name=script}

    <script>

    </script>


{/block}

