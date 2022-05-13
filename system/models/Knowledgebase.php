<?php
use Illuminate\Database\Eloquent\Model;

class Knowledgebase extends Model
{
    protected $table = 'ib_kb';

    public static function saveArticle($data)
    {
        $article = new self();
        $article->title = $data['title'];
        $article->slug = Str::slug($data['title']);
        $article->status = 'Published';
        $article->description = $data['description'];
        $article->save();
        $article_group = KnowledgebaseGroup::where(
            'gname',
            $data['group']
        )->first();
        if ($article_group) {
            $relation = new KnowledgebaseGroupRelation();
            $relation->kbid = $article->id;
            $relation->gid = $article_group->id;
            $relation->save();
        }
    }
}
