{extends file="$layouts_base"}

{block name="head"}

    <style>
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
        <div class="flex-1">
            <div class="container py-4 py-lg-5 my-lg-5 px-4 px-sm-0">

                <div class="mx-auto" style="max-width: 600px;">
                    <div class="card p-4">

                        <h1 class="mb-3 text-center">
                            {$plugin['name']}
                        </h1>

                        {if isset($notify)}
                            {$notify}
                        {/if}

                        <p class="my-3"><span  id="countmsg">Please Wait...</span> Or <a href="{$_url}settings/plugins/">Click Here.</a> </p>

                        <textarea class="form-control" rows="10">{$msg}</textarea>


                    </div>
                </div>


                <div class="position-absolute pos-bottom pos-left pos-right p-3 text-center">
                    &copy; {date('Y')} {$config['CompanyName']}
                </div>
            </div>
        </div>
    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            var count = 20;
            var countdown = setInterval(function(){
                $("#countmsg").html("Redirecting in " + count + " seconds!");

                if (count == 0) {
                    clearInterval(countdown);
                    window.open('https://business-suite.test/?ng=settings/plugins/', "_self");

                }
                count--;
            }, 1000);
        });
    </script>
{/block}
