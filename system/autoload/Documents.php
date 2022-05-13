<?php
class Documents
{
    public static function assign(
        $path,
        $title = '',
        $is_global = '0',
        $rid = '',
        $rtype = '',
        $data = []
    ) {
        if ($is_global != '1') {
            $is_global = '0';
        }

        $ext = pathinfo($path, PATHINFO_EXTENSION);

        $token = Misc::random_string(30);

        if ($title == '' || $path == '') {
            return false;
        }

        $d = new Document();
        $d->title = $title;
        $d->file_path = $path;
        $d->file_dl_token = $token;
        $d->file_mime_type = $ext;
        $d->is_global = $is_global;
        $d->aid = $data['admin_id'] ?? 0;
        $d->save();

        $did = $d->id;

        if ($rid != '' && $rtype != '') {
            $r = new DocumentRelation();

            $r->rtype = $rtype;
            $r->rid = $rid;
            $r->did = $did;

            $r->save();
        }

        return $did;
    }
}
