<?php
use Illuminate\Database\Eloquent\Model;

class HostingPlanGroup extends Model
{
    public static function saveGroup($data)
    {
        $create_hosting_plan_group = new self();
        $create_hosting_plan_group->name = $data['name'];
        $create_hosting_plan_group->type = $data['type'];
        $create_hosting_plan_group->slug = Str::slug($data['name']);
        $create_hosting_plan_group->header_content =
            $data['header_content'] ?? null;
        $create_hosting_plan_group->save();
    }
}
