<!DOCTYPE html>
<html lang="en" {if !empty($config['font_size'])} class="{$config['font_size']}" {/if}>
<head>
    <meta charset="utf-8">
    <title>
        {$_title}
    </title>
    <meta name="description" content="{$config['CompanyName']}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="msapplication-tap-highlight" content="no">
    <link rel="icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-32','icon-32x32.png')}" sizes="32x32" />
    <link rel="icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-192','icon-192x192.png')}" sizes="192x192" />
    <link rel="apple-touch-icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-180','icon-180x180.png')}" />
    <meta name="msapplication-TileImage" content="{{APP_URL}}/storage/system/{get_or_default($config,'icon-270','icon-270x270.png')}" />
    <script>
        const cloudonex_csrf_token = '{csrf_token()}';
    </script>

    {if isset($config['header_scripts'])}
        {$config['header_scripts']}
    {/if}

    {if APP_STAGE == 'Dev'}

        {if $config['rtl'] eq '1'}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app-rtl.min.css?v={{_raid()}}">
            <style>
                .nav-menu li a>svg {
                    margin-left: .75rem;
                }
            </style>
        {else}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app.min.css?v={{_raid()}}">
            <style>
                .nav-menu li a>svg {
                    margin-right: .75rem;
                }
            </style>
        {/if}

    {else}

        {if $config['rtl'] eq '1'}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app-rtl.min.css">
            <style>
                .nav-menu li a>svg {
                    margin-left: .75rem;
                }
            </style>
        {else}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app.min.css">
            <style>
                .nav-menu li a>svg {
                    margin-right: .75rem;
                }
            </style>
        {/if}
    {/if}


    <style>

        body {
            font-size: 14px;
            color: #2b2b2b;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            color: #2b2b2b;
        }
        .nav-menu li.active {
            background: #cae2f4;
        }

        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li.active a {
            color: #3799e4;
        }
        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li a {
            color:  #3799e4;
        }
        .clx-navigation-type-top .page-header {
            background-color: #3799e4;
        }

        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li > ul {
            background: #fff;
        }
        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li > ul li a {
            color: rgba(255, 255, 255, 0.7);
        }
        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li > ul li a {
            color: #000;
        }
        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu>li>a>.collapse-sign>em:before {
            color: #3799e4;
        }
        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li.active > ul li a {
            color: #000;
        }
        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu>li>ul {
            top: 2.5rem;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu>li>a>.nav-link-text {
            font-weight: 700;
        }
        .alert.alert-danger.fade{
            opacity: 1;
        }
        .alert.alert-success.fade{
            opacity: 1;
        }

        #ribbon-container {
            position: absolute;
            right: -15px;
        }


        #ribbon-container:before {
            content: "";
            height: 0;
            width: 0;
            display: block;
            position: absolute;
            top: 3px;
            left: 0;
            border-top: 20px solid rgba(0,0,0,.3);
            border-bottom: 20px solid rgba(0,0,0,.3);
            border-right: 20px solid rgba(0,0,0,.3);
            border-left: 20px solid transparent;
        }
        #ribbon-container a {
            display: block;
            padding: 12px;
            position: relative;
            background: #0089d0;
            overflow: visible;
            height: 40px;
            margin-left: 29px;
            color: #fff;
            text-decoration: none;
        }
        #ribbon-container a:before {
            content: "";
            height: 0;
            width: 0;
            display: block;
            position: absolute;
            top: 0;
            left: -20px;
            border-top: 20px solid #0089d0;
            border-bottom: 20px solid #0089d0;
            border-right: 20px solid transparent;
            border-left: 20px solid transparent;
        }
        #ribbon-container a:after {
            content: "";
            height: 0;
            width: 0;
            display: block;
            position: absolute;
            bottom: -15px;
            right: 0;
            border-top: 15px solid #004a70;
            border-right: 15px solid transparent;
        }



        .pristine-error.text-help {
            color: red;
        }

        .clx-navigation-type-top .page-sidebar {
            background: #6969FF;
        }


        .clx-navigation-type-top .page-sidebar {
            background: #fff;
        }

        .svg-fill-white svg{
            fill: white;
        }

        .page-content-wrapper{
            background: #EBF1F6;
        }

    </style>

    {block name=head_extras_from_layout}{/block}
    {block name=head}{/block}


    <style>
        .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li > ul li:hover > a {
            color: #6969FF;
        }
        .header-icon:not(.btn)[data-toggle=dropdown][data-toggle=dropdown]:after {
            background: #4c8ec4;
        }

        .card{
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 24px 0 rgb(34 41 47 / 10%);
        }
        .clx-list-with-padding li{
            position: relative;
            padding: 8px 0 8px 25px;
            font-size: 16px;
        }


        .clx-pricing-table .pt-head:after {
            content: "";
            position: absolute;
            top: -50px;
            left: -20px;
            right: -10px;
            bottom: 0;
            background: #4C3FB9;
            z-index: -1;
            transform: rotate(
                    -7deg
            );
        }
        .z-index-1 {
            z-index: 1;
        }

        .clx-pricing-table.featured .pt-head:after {
            background: #15db95;
        }

        label{
            font-weight: bold;
        }

        .nav-menu li a>svg {
            margin-right: .75rem;
        }

        .nav-menu li.active>a {
            -webkit-box-shadow: none;
            box-shadow: none;
        }

        .table.invoice-items{
            border: 1px solid #dee2e6;
        }

        .table.invoice-items td, .table.invoice-items th {
            border: 1px solid #dee2e6;
        }


    </style>

    <script>
        var base_url = '{$_url}';
        var block_msg = '<div class="md-preloader text-center"><svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="32" width="32" viewbox="0 0 75 75"><circle cx="37.5" cy="37.5" r="33.5" stroke-width="6"/></svg></div>';
    </script>



    <script>
        window.clx = {
            base_url: '{$_url}',
            i18n: {
                yes: '{$_L['Yes']}',
                no: '{$_L['No']}',
                are_you_sure: '{$_L['are_you_sure']}'
            },
            theme_options: false,
        };
        var _L = [];
        _L['Save'] = '{$_L['Save']}';
        _L['Submit'] = '{$_L['Submit']}';
        _L['Loading'] = '{$_L['Loading']}';
        _L['OK'] = '{$_L['OK']}';
        _L['Cancel'] = '{$_L['Cancel']}';
        _L['Close'] = '{$_L['Close']}';
        _L['are_you_sure'] = '{$_L['are_you_sure']}';
        _L['Saved Successfully'] = '{$_L['Saved Successfully']}';
        _L['Empty'] = '{$_L['Empty']}';
    </script>

    {foreach $append_to_the_head_in_the_base_layout as $append_to_the_head_in_the_base_layout_content}
        {$append_to_the_head_in_the_base_layout_content}
    {/foreach}

</head>
<body class="clx-navigation-type-top clx-fixed-header clx-fixed-navigation" id="cloudonex_body">
<script>
    'use strict';

    var classHolder = document.getElementsByTagName("BODY")[0],
        themeSettings = (localStorage.getItem('themeSettings')) ? JSON.parse(localStorage.getItem('themeSettings')) :
            { },
        themeURL = themeSettings.themeURL || '',
        themeOptions = themeSettings.themeOptions || '';
    if (themeSettings.themeOptions)
    {
        classHolder.className = themeSettings.themeOptions;
    }
    else
    {
    }
    var saveSettings = function()
    {
        themeSettings.themeOptions = String(classHolder.className).split(/[^\w-]+/).filter(function(item)
        {
            return /^(nav|header|footer|mod|display)-/i.test(item);
        }).join(' ');
        localStorage.setItem('themeSettings', JSON.stringify(themeSettings));
    }
    var resetSettings = function()
    {
        localStorage.setItem("themeSettings", "");
    }

</script>


<div class="page-wrapper">

    <div class="page-inner">
        {block name="content_body"}{/block}
    </div>

</div>



<input type="hidden" id="_url" name="_url" value="{$_url}">
<input type="hidden" id="_df" name="_df" value="{$config['df']}">

{if APP_STAGE == 'Dev'}
    <script src="{{APP_URL}}/ui/theme/default/js/app.min.js?v={_raid()}"></script>
    <script src="{{APP_URL}}/ui/lib/ray.js?v=3"></script>
{else}
    <script src="{{APP_URL}}/ui/theme/default/js/app.min.js"></script>
{/if}

<script>
    if (typeof window.ray === 'undefined') {
        window.ray = function() {
            console.log('ray is available only on the dev mode.')
        }
    }

    (function (factory) {
        if (typeof define === "function" && define.amd) {
            define(["jquery"], factory);
        } else {
            factory(jQuery);
        }
    })(function ($) {

        "use strict";

        $.fn.datepicker.setDefaults({
            autoClose: false,
            dateFormat: "mm/dd/yy",
            days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
            daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            daysMin: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
            months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
            monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            showMonthAfterYear: false,
            viewStart: 0, // days
            weekStart: 0, // Sunday
            yearSuffix: ""
        });
    });
</script>

{block name=script}{/block}

{if isset($config['footer_scripts'])}
    {$config['footer_scripts']}
{/if}

</body>
</html>
