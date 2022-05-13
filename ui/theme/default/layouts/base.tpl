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
    <!-- Call App Mode on ios devices -->
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- Remove Tap Highlight on Windows Phone IE -->
    <meta name="msapplication-tap-highlight" content="no">
    <!-- base css -->

    <link rel="icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-32','icon-32x32.png')}" sizes="32x32" />
    <link rel="icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-192','icon-192x192.png')}" sizes="192x192" />
    <link rel="apple-touch-icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-180','icon-180x180.png')}" />
    <meta name="msapplication-TileImage" content="{{APP_URL}}/storage/system/{get_or_default($config,'icon-270','icon-270x270.png')}" />

    {if APP_STAGE == 'Dev'}

        {if $config['rtl'] eq '1'}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app-rtl.min.css?v={{_raid()}}">
        {else}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app.min.css?v={{_raid()}}">

        {/if}

        <link href="{$theme}default/css/themes/{$config['nstyle']}.css?v={{_raid()}}" rel="stylesheet">

    {else}

        {if $config['rtl'] eq '1'}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app-rtl.min.css?v=26">
        {else}
            <link id="css_app" rel="stylesheet" media="screen, print" href="{{APP_URL}}/ui/theme/default/css/app.min.css?v={$file_build}">
        {/if}

        <link href="{$theme}default/css/themes/{$config['nstyle']}.css?v={$file_build}" rel="stylesheet">
    {/if}


    <style>

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


        .alert-danger {
            color: #e7026e;
            background-color: #ffe5f1;
        }


        .alert-success {
            color: #45a197;
            background-color: #f7fdfc;
            border-color: #a3ebe4;
        }



        .pristine-error.text-help {
            color: red;
        }


    </style>

    {block name=head_extras_from_layout}{/block}
    {block name=head}{/block}





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
            }
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

</head>
<body class="mod-bg-1 mod-nav-link" id="cloudonex_body">
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


<p id="js-color-profile" class="d-none">
    <span class="color-primary-50"></span>
    <span class="color-primary-100"></span>
    <span class="color-primary-200"></span>
    <span class="color-primary-300"></span>
    <span class="color-primary-400"></span>
    <span class="color-primary-500"></span>
    <span class="color-primary-600"></span>
    <span class="color-primary-700"></span>
    <span class="color-primary-800"></span>
    <span class="color-primary-900"></span>
    <span class="color-info-50"></span>
    <span class="color-info-100"></span>
    <span class="color-info-200"></span>
    <span class="color-info-300"></span>
    <span class="color-info-400"></span>
    <span class="color-info-500"></span>
    <span class="color-info-600"></span>
    <span class="color-info-700"></span>
    <span class="color-info-800"></span>
    <span class="color-info-900"></span>
    <span class="color-danger-50"></span>
    <span class="color-danger-100"></span>
    <span class="color-danger-200"></span>
    <span class="color-danger-300"></span>
    <span class="color-danger-400"></span>
    <span class="color-danger-500"></span>
    <span class="color-danger-600"></span>
    <span class="color-danger-700"></span>
    <span class="color-danger-800"></span>
    <span class="color-danger-900"></span>
    <span class="color-warning-50"></span>
    <span class="color-warning-100"></span>
    <span class="color-warning-200"></span>
    <span class="color-warning-300"></span>
    <span class="color-warning-400"></span>
    <span class="color-warning-500"></span>
    <span class="color-warning-600"></span>
    <span class="color-warning-700"></span>
    <span class="color-warning-800"></span>
    <span class="color-warning-900"></span>
    <span class="color-success-50"></span>
    <span class="color-success-100"></span>
    <span class="color-success-200"></span>
    <span class="color-success-300"></span>
    <span class="color-success-400"></span>
    <span class="color-success-500"></span>
    <span class="color-success-600"></span>
    <span class="color-success-700"></span>
    <span class="color-success-800"></span>
    <span class="color-success-900"></span>
    <span class="color-fusion-50"></span>
    <span class="color-fusion-100"></span>
    <span class="color-fusion-200"></span>
    <span class="color-fusion-300"></span>
    <span class="color-fusion-400"></span>
    <span class="color-fusion-500"></span>
    <span class="color-fusion-600"></span>
    <span class="color-fusion-700"></span>
    <span class="color-fusion-800"></span>
    <span class="color-fusion-900"></span>
</p>

<input type="hidden" id="_url" name="_url" value="{$_url}">
<input type="hidden" id="_df" name="_df" value="{$config['df']}">

{if APP_STAGE == 'Dev'}
    <script src="{{APP_URL}}/ui/theme/default/js/app.min.js?v={_raid()}"></script>
    <script src="{{APP_URL}}/ui/lib/ray.js"></script>
{else}
    <script src="{{APP_URL}}/ui/theme/default/js/app.min.js?v={$file_build}"></script>
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

</body>
</html>
