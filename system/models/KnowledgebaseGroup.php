<?php
use Illuminate\Database\Eloquent\Model;
class KnowledgebaseGroup extends Model
{
    protected $table = 'ib_kb_groups';

    public static function saveGroup($data)
    {
        $group = new self();
        $group->gname = $data['name'];
        $group->save();
    }
}
