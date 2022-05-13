{extends file="$layouts_admin"}


{block name="content"}

    <div style="max-width: 1000px; width: 100%;" class="mx-auto">
        <div class="panel">
            <div class="panel-hdr">
                <h2>{$_L['Form Builder']}</h2>
                <div class="panel-toolbar">
                    <div class="btn-group">
                        <a target="_blank" href="{$_url}client/form/{$lead_form->uuid}/" class="btn btn-primary">{$_L['Preview']}</a>
                        <a href="{$_url}leads/form-embed/{$lead_form->id}/" class="btn btn-success">{$_L['Embed']}</a>
                    </div>
                </div>
            </div>
            <div class="panel-container">
                <div class="panel-content">



                    <div id="clx_form_builder_wrap"></div>


                </div>
            </div>
        </div>
    </div>

{/block}

{block name=script}

    <script type="text/javascript" src="{$app_url}ui/lib/form-builder.min.js"></script>

    <script>

        $(function () {

            var $clx_form_builder_wrap = $('#clx_form_builder_wrap');


            var formBuilder = $clx_form_builder_wrap.formBuilder({
                disableFields: [
                    'autocomplete',
                    'button',
                    'checkbox',
                    'checkbox-group',
                    'date',
                    'hidden',
                    'number',
                    'radio-group',
                    'select',
                    'text',
                    'textarea',
                    'datetime-local',
                    'file',
                ],
                disabledActionButtons: [
                    'data',
                    'clear'
                ],
                controlPosition: 'left',
                controlOrder: [
                    'header',
                    'paragraph',
                ],
                inputSets: [
                    {
                        "label": "{$_L['First Name']}",
                        "name": "first_name",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['First Name']}",
                                "className": "form-control",
                                "name": "first_name",
                                "required": true
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Last Name']}",
                        "name": "last_name",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['Last Name']}",
                                "className": "form-control",
                                "name": "last_name",
                                "required": true
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Title']}",
                        "name": "title",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['Title']}",
                                "className": "form-control",
                                "name": "title"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Company']}",
                        "name": "company",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['Company']}",
                                "className": "form-control",
                                "name": "company",
                                "required": true
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Email']}",
                        "name": "email",
                        "fields": [
                            {
                                "subtype": "email",
                                "type": "text",
                                "label": "{$_L['Email']}",
                                "className": "form-control",
                                "name": "email"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Phone']}",
                        "name": "phone",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['Phone']}",
                                "className": "form-control",
                                "name": "phone"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Address']}",
                        "name": "street",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['Address']}",
                                "className": "form-control",
                                "name": "street"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['City']}",
                        "name": "city",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['City']}",
                                "className": "form-control",
                                "name": "city"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['State Region']}",
                        "name": "state",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['State Region']}",
                                "className": "form-control",
                                "name": "state"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['ZIP Postal Code']}",
                        "name": "zip",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['ZIP Postal Code']}",
                                "className": "form-control",
                                "name": "zip"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Country']}",
                        "name": "country",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "select",
                                "label": "{$_L['Country']}",
                                "className": "custom-select",
                                "name": "country",
                                "values": [
                                    {
                                        "label": "",
                                        "value": "",
                                        "selected": false
                                    },
                                    {foreach Countries::list() as $key=> $value}
                                    {
                                        "label": "{$value}",
                                        "value": "{$key}",
                                        "selected": {if strtoupper($config['country_code']) == $key} true {else} false{/if}
                                    },
                                    {/foreach}
                                ]
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Description']}",
                        "name": "description",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "textarea",
                                "label": "{$_L['Description']}",
                                "className": "form-control",
                                "name": "memo"
                            }
                        ]
                    },
                    {
                        "label": "{$_L['Website']}",
                        "name": "website",
                        "fields": [
                            {
                                "subtype": "",
                                "type": "text",
                                "label": "{$_L['Website']}",
                                "className": "form-control",
                                "name": "website"
                            }
                        ]
                    }
                ],
                {if $lead_form->form_data}
                formData: {$lead_form->form_data},
                {/if}
                onSave: function(event, formData) {
                    $.post( base_url + 'leads/save-form-data', {
                        id: {$lead_form->id},
                        form_data: formData,
                    })
                        .done(function( data ) {

                            location.reload();

                        }).fail(function (error) {
                        console.log(error);
                    });
                },
            });



        });

    </script>


{/block}
