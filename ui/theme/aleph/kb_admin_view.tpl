<div>
    <div class="panel shadow-none mb-0">
        <div class="panel-hdr">
            <h2>
                {$kb->title}
            </h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <div class="btn-group">
                    <a class="btn btn-primary" href="{$_url}kb/a/edit/{$kb->id}/">{$_L['Edit']}</a>
                    <a class="btn btn-danger" onclick="deleteKb('{$kb->id}')" href="javascript:;">{$_L['Delete']}</a>
                </div>
                <div class="hr-line-dashed"></div>
                {$kb->description}
            </div>
        </div>
    </div>
</div>
