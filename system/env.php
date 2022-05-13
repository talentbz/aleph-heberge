<?php
return [
    'cache' => [
        'default' => 'file',
        'stores' => [
            'file' => [
                'driver' => 'file',
                'path' => 'storage/cache/system',
            ],
        ],
    ],
    'filesystems' => [
        'default' => 'local',

        'disks' => [
            'local' => [
                'driver' => 'local',
                'root' => './',
            ],
        ],
    ],
];
