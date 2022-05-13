<?php
use Illuminate\Database\Eloquent\Model;

class HostingPlan extends Model
{
    public static function savePlan($data)
    {
        $hosting_plan_group = false;

        if (!empty($data['group'])) {
            $hosting_plan_group = HostingPlanGroup::where(
                'slug',
                $data['group']
            )->first();
            if ($hosting_plan_group) {
                $group_id = $hosting_plan_group->id;
                $type = $hosting_plan_group->type;
            }
        }

        if (!$hosting_plan_group) {
            return [
                'success' => false,
                'errors' => [
                    'group' => 'Group not found',
                ],
            ];
        }

        $hosting_plan = new self();
        $hosting_plan->name = $data['name'];
        $hosting_plan->slug = Str::slug($data['name']);
        $hosting_plan->group_id = $group_id;
        $hosting_plan->type = $type;
        $hosting_plan->price_monthly = $data['price_monthly'] ?? 0;
        $hosting_plan->price_yearly = $data['price_yearly'] ?? 0;
		$hosting_plan->price_plesk = $data['price_plesk'] ?? 0;
        $hosting_plan->one_time_fee = $data['one_time_fee'] ?? 0;
        $hosting_plan->features = json_encode($data['features'] ?? []);
        $hosting_plan->allow_free_domain = $data['allow_free_domain'] ?? 0;
        $hosting_plan->featured = $data['featured'] ?? 0;
        $hosting_plan->require_domain_name = $data['require_domain_name'] ?? 0;
        $hosting_plan->save();
    }
}
