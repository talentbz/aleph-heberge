{extends file="layouts/base.tpl"}
{block name="head_extras_from_layout"}

    <style>
        .pristine-error.text-help {
            color: red;
        }
        @media (min-width: 992px){
            .clx-fixed-navigation:not(.clx-navigation-type-top):not(.nav-function-hidden):not(.nav-function-minify) .page-content-wrapper {
                padding-left: 0;
            }
        }
    </style>
{/block}



{block name="content_body"}
    <div class="page-content-wrapper bg-transparent m-0">
        <div class="height-10 w-100 shadow-sm px-4 bg-brand-gradient">
            <div class="d-flex align-items-center container p-0">
                <div class="page-logo width-mobile-auto m-0 align-items-center justify-content-center p-0 bg-transparent bg-img-none shadow-0 height-9 border-0">
                    <a href="{APP_URL}" class="page-logo-link press-scale-down d-flex align-items-center">
                        {if isset($config['logo_square'])}
                            <img src="{{APP_URL}}/storage/system/{{$config['logo_square']}}" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                        {else}
                            <img src="{{APP_URL}}/storage/system/logo-512x512.png?v=2" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                        {/if}
                        {if isset($config['logo_text'])}
                            <span class="page-logo-text mr-1">{$config['logo_text']}</span>
                        {else}
                            <span class="page-logo-text mr-1">CloudOnex</span>
                        {/if}
                    </a>
                </div>




            </div>
        </div>

        {block name="content"}

        {/block}

    </div>
{/block}

{block name="script"}
    <script>
        $(function () {



        });
    </script>
{/block}
