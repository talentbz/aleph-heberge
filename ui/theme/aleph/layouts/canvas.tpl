{if isset($config['base_layout'])}
    {extends file=$config['base_layout']}
    {else}
    {extends file="layouts/base.tpl"}
{/if}


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

    {block name="content"}

    {/block}

{/block}


{block name="script"}
    <script>
        $(function () {



        });
    </script>
{/block}
