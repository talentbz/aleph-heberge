<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

authenticate_admin();

$action = route(1);
switch ($request_method) {
    case 'GET':
        switch ($action) {
            case '':
            case 'posts':
                \view('posts', []);

                break;

            case 'schema':
                is_dev();

                DB::schema()->dropIfExists('cms_posts');

                DB::schema()->create('cms_posts', function ($table) {
                    $table->increments('id');
                    $table->unsignedInteger('parent_id')->default(0);
                    $table->unsignedInteger('collection_id')->default(0);
                    $table->unsignedInteger('single_category_id')->default(0);
                    $table->string('type', 100)->nullable();
                    $table->string('template', 50)->nullable();
                    $table->string('header_type', 50)->nullable();
                    $table->string('api_name')->nullable();
                    $table->string('slug');
                    $table->string('name')->nullable();
                    $table->string('title');
                    $table->string('seo_title')->nullable();
                    $table->text('excerpt')->nullable();
                    $table->text('lead_text')->nullable();
                    $table->text('keywords')->nullable();
                    $table->text('meta_tag')->nullable();
                    $table->text('meta_description')->nullable();
                    $table->text('meta_keywords')->nullable();
                    $table->longText('markdown')->nullable();
                    $table->longText('content');
                    $table->longText('head')->nullable();
                    $table->longText('js')->nullable();
                    $table->string('featured_image')->nullable();
                    $table->string('featured_video')->nullable();
                    $table->string('youtube_video_id')->nullable();
                    $table->string('vimeo_video_id')->nullable();
                    $table->string('canonical_url')->nullable();
                    $table->unsignedInteger('reading_time')->default(0);
                    $table->boolean('is_published')->default(0);
                    $table->boolean('is_home_page')->default(0);
                    $table->boolean('is_system_page')->default(0);
                    $table->boolean('is_pinned')->default(0);
                    $table->boolean('show_date')->default(1);
                    $table->boolean('allow_comment')->default(0);
                    $table->boolean('is_page')->default(0);
                    $table->unsignedInteger('author_id')->default(0);
                    $table->unsignedInteger('sort_order')->default(0);
                    $table->unsignedInteger('item_id')->default(0);
                    $table->boolean('is_cached')->default(0);
                    $table->text('components')->nullable();
                    $table->text('styles')->nullable();
                    $table->text('settings')->nullable();
                    $table->timestamps();
                });

                break;
        }
}
