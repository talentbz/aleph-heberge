{extends file="hostbilling/layouts/new_base/base.tpl"}

{block name="new_content"}
<main id="clx-page-content" role="main" class="page-content">


    <div class="mx-auto" style="width: 800px">

        <a class="btn btn-primary my-3" href="{$base_url}client/kb/">{$_L['Back to the List']}</a>

        <div class="card">

            <div class="card-body">

                <h1 class="text-center mb-3"> {$article->title} </h1>
                <p>
                    {$article->description}
                </p>


            </div>

        </div>



    </div>

</main>
{/block}

