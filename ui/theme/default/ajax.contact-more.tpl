<div id="croppic"></div>

<button type="button" id="cropContainerHeaderButton" class="btn btn-info">{$_L['Upload Picture']}</button>
<button type="button" id="opt_gravatar" class="btn btn-info">{$_L['Use Gravatar']}</button>
<button type="button" id="no_image" class="btn btn-default">{$_L['No Image']}</button>
<div class="mt-3"> </div>
<form class="form-horizontal">

    <div class="form-group"><label for="picture">{$_L['Picture']}</label>

        <input type="text" id="picture" readonly name="picture" class="form-control picture" {if $d['img']} value="{$app_url}{$d['img']}" {/if} autocomplete="off">
    </div>

    <div class="form-group"><label for="facebook">{$_L['Facebook Profile']}</label>

        <input type="text" id="facebook" name="facebook" class="form-control" value="{$d['facebook']}" autocomplete="off">
    </div>

    <div class="form-group"><label for="google">{$_L['Google Plus Profile']}</label>

        <input type="text" id="google" name="google" class="form-control" value="{$d['google']}" autocomplete="off">
    </div>
    <div class="form-group"><label for="linkedin">{$_L['Linkedin Profile']}</label>
        <input type="text" id="linkedin" name="linkedin" value="{$d['linkedin']}" class="form-control" autocomplete="off">
    </div>


    <div class="form-group">
        <button class="btn btn-primary" type="submit" id="more_submit"><i class="fal fa-check"></i> {$_L['Submit']}</button>
    </div>
</form>
