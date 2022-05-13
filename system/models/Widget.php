<?php
use Illuminate\Database\Eloquent\Model;

class Widget extends Model
{
    public static function defaultWidget($key)
    {
        $widgets = [
            'client-auth-page-widget' => '<h2>Welcome to CloudOnex</h2>
<p>In this widget, you can add a notice, CTA, or any content you want. This widget only shows here on the client portal page. Only admin can edit this widget. If you are logged in as admin, you will see an edit button above. If you do not see the toolbar above, <a id="login_as_admin" href="javascript:;">log in as admin</a> and revisit this page.</p>
<p>To change the above logo, login as admin then go to customize under appearance.</p>
<p>The footer brand name comes from your company name. Edit the name from general settings under Settings.</p>',
        ];

        return $widgets[$key] ?? '';
    }

    public static function getWidgetContent($type)
    {
        $widget = self::where('type',$type)->first();
        if($widget && $widget->content)
        {
            return $widget->content;
        }
        return  self::defaultWidget($type);
    }
}
