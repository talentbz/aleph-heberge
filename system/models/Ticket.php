<?php
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    protected $table = 'sys_tickets';

    public static function saveTicket($data)
    {
        # To generate sample data for testing
        $ticket = new self();
        $ticket->tid = create_tracking_id();
        $ticket->did = 1;
        $ticket->aid = 1;
        $ticket->dname = 'Support';
        $ticket->account = 'Maria Elizabeth';
        $ticket->userid = 294;
        $ticket->email = 'client@example.com';
        $ticket->subject = $data['subject'];
        $ticket->status = $data['status'] ?? 'Open';
        $ticket->urgency = $data['urgency'] ?? 'Medium';
        $ticket->save();
    }
}
