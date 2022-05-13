{extends file="$layouts_client"}

{block name="head"}


    <style>
        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600;
            line-height: 1.5;
            margin-bottom: .5rem;
            color: #32325d;}
        .text-info{
            color: #6772E5!important;
        }
        .text-success{
            color: #2CCE89!important;}
    </style>
{/block}

{block name="content"}

    <div class="row">
        <div class="col-md-12">


            <div class="panel">
                <div class="panel-container">
                    <div class="panel-content ">
                        <h3 class="h2">{$article->title}</h3>
                        <em class="text-info">{$adm->fullname}</em> {if $article->updated_at != ''} | <em>Last update: {$article->updated_at->diffForHumans()}</em> {/if}
                        <hr>

                        {$article->description}
                    </div>



                </div>
            </div>


        </div>
    </div>

{/block}