{extends file="hostbilling/layouts/client.tpl"}



{block name="content"}

    <div class="card">
        <div class="card-body">
            <h3>{$order->tracking_id}</h3>
            <div class="hr-line-dashed"></div>
            <strong>Status:</strong> {cloudonex_get_order_status_with_badge($order->status)}
            <div class="mt-3">
                <h4>{$order->activation_subject}</h4>
            </div>
            <div class="mt-3">
                {$order->activation_message}
            </div>
        </div>
    </div>

{/block}

{block name=script}

    <script>

    </script>


{/block}
