<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('selected_navigation', 'calendar');
$ui->assign('_title', $_L['Calendar'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);

Event::trigger('calendar');

switch ($action) {
    case 'events':
        $mdate = date('Y-m-d');
        $ui->assign('mdate', $mdate);

        view('calendar');

        break;

    case 'save_event':
        $data = ib_posted_data();

        $start = date('Y-m-d', strtotime($data['start']));

        if ($data['end'] != '') {
            $end = date('Y-m-d', strtotime($data['end']));
        } else {
            $end = $start;
        }

        if (isset($data['all_day_event'])) {
            $start_date = $start . ' 00:00:00';
            $end_date = $end . ' 23:59:59';
            $allday = 1;
        } else {
            $start_time = date("H:i", strtotime($data['start_time']));
            $end_time = date("H:i", strtotime($data['end_time']));

            $start_date = $start . ' ' . $start_time . ':00';
            $end_date = $end . ' ' . $end_time . ':59';
            $allday = 0;
        }

        if (isset($data['event_id'])) {
            $event_id = $data['event_id'];

            $calendar = Calendar::find($event_id);

            if (!$calendar) {
                i_close('Event not Found.');
            }
        } else {
            $calendar = new Calendar();
        }

        $calendar->title = $data['title'];
        $calendar->start = $start_date;
        $calendar->end = $end_date;
        $calendar->description = $data['description'];
        $calendar->color = $data['color'];
        $calendar->allday = $allday;
        $calendar->aid = $user->id;
        $calendar->save();

        echo $calendar->id;

        break;

    case 'data':
        header('Content-Type: application/json');

        $start = _get('start') . ' 00:00:00';
        $end = _get('end') . ' 23:59:00';

        $x = Calendar::where('start', '>=', $start)
            ->where('end', '<=', $end)
            ->select([
                'title',
                'start',
                'end',
                'description AS _tooltip',
                'id',
                'color',
            ]);

        if (!has_access($user->roleid, 'calendar', 'all_data')) {
            $x->where('aid', $user->id);
        }

        $calendar = $x->get()->all();

        echo json_encode($calendar);

        break;

    case 'js_date':
        $date = _post('date');

        echo date('Y-m-d', strtotime(current(explode("(", $date))));

        break;

    case 'view_event':
        $id = route(2);

        $calendar = Calendar::find($id);

        if ($calendar) {
            header('Content-Type: application/json');

            $data = [];
            $data['id'] = $calendar->id;
            $data['title'] = $calendar->title;
            $data['start_date'] = date('Y-m-d', strtotime($calendar->start));
            $data['start_time'] = date('H:i', strtotime($calendar->start));
            $data['end_date'] = date('Y-m-d', strtotime($calendar->end));
            $data['end_time'] = date('H:i', strtotime($calendar->end));
            $data['color'] = $calendar->color;
            $data['description'] = $calendar->description;
            if ($calendar->allday == 1) {
                $data['allDay'] = true;
            } else {
                $data['allDay'] = false;
            }

            echo json_encode($data);
        }

        break;

    case 'event':
        $id = route(2, 0);
        $date = route(3, 0);

        $event = false;

        if ($id) {
            $event = Calendar::find($id);

            if ($event) {
                $date = date('Y-m-d', strtotime($event->start));
            }
        }

        if (!$date) {
            $date = date('Y-m-d');
        }

        view('calendar_event', [
            'date' => $date,
            'event' => $event,
        ]);

        break;

    case 'delete-event':
        $id = route(2, 0);
        if ($id) {
            $event = Calendar::find($id);

            if ($event) {
                $event->delete();
            }
        }

        r2(U . 'calendar/events');
        break;

    default:
        echo 'action not defined';
}
