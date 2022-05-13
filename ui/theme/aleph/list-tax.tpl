{extends file="$layouts_admin"}
{block name="head"}

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />
    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;

        }
        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600;
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
            <h2>{$_L['Sales Taxes']} </h2>
            <div class="panel-toobar">
                <a href="{$_url}settings/add-tax/" id="item_add" class="btn btn-primary"><i class="fal fa-plus"></i> {$_L['Add Tax']} </a>
            </div>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <table class="table table-bordered table-striped table-hover sys_table">
                    <thead>
                    <tr>
                        <th class="h6">{$_L['Name']}</th>
                        <th class="h6">{$_L['Tax Rate']}</th>

                        <th class="h6 text-right">{$_L['Manage']}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $d as $ds}
                        <tr id="{$ds['id']}">
                            <td> {if $ds['is_default'] eq '1'} <label class="label label-success label-sm">{$_L['Default']}</label> {/if} {$ds['name']} </td>
                            <td>


                                {if $ds['rate'] eq '0.000' || $ds['rate'] eq '0.00'}
                                    0%
                                {elseif $ds['rate'] eq '5.000'}
                                    5%
                                {else}
                                    {$ds['rate']}%
                                {/if}



                            </td>
                            <td class="text-right">
                                <a href="{$_url}settings/edit-tax/{$ds['id']}/" class="btn btn-secondary"><i class="fal fa-pencil"></i> {$_L['Edit']} </a>


                                {if $ds['is_default'] neq '1'}
                                    <a href="{$_url}settings/tax-make-default/{$ds['id']}/" class="btn btn-info"><i class="fal fa-star"></i> {$_L['Make Default']} </a>
                                {/if}
                                <button type="button" id="t{$ds['id']}" class="btn btn-danger cdelete"><i class="fal fa-trash-alt"></i> {$_L['Delete']} </button>
                            </td>

                        </tr>
                    {/foreach}

                    </tbody>
                </table>
            </div>
        </div>






    </div>
    <input type="hidden" id="_lan_are_you_sure" value="{$_L['are_you_sure']}">
{/block}

{block name="script"}
    <script>
        $(function () {
            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        window.location.href = base_url + "tax/delete/" + id;
                    }
                });
            });
        });
    </script>
{/block}
