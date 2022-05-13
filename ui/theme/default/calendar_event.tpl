<div style="max-width: 800px;" class="mx-auto">
    <div class="panel mb-0 rounder-0">
        <div class="panel-hdr">
            <h2>{$_L['Add Event']}</h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">

                <form method="post" id="eventForm">

                    <div class="form-group">
                        <label for="title">{$_L['Event Name']}</label>
                        <input type="text" class="form-control" id="title" name="title" {if $event}value="{$event->title}" {/if} required>
                    </div>



                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="start">{$_L['Start Date']}</label>
                            <input type="text" class="form-control" data-date-format="yyyy-mm-dd" data-auto-close="true" id="start" placeholder="Select Date" name="start" value="{$date}">
                        </div>

                        <div class="form-group col-md-6" id="start_time_div">
                            <label for="start_time">{$_L['Start Time']}</label>
                            <input type="text" id="start_time" name="start_time" class="form-control"  {if $event && $event->start}value="{date('h:ia',strtotime($event->start))}" {else} value="9:30am" {/if}>
                        </div>
                    </div>



                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="end">{$_L['End Date']}</label>
                            <input type="text" class="form-control" {if $event && $event->end}value="{date('Y-m-d',strtotime($event->end))}" {/if} datepicker data-date-format="yyyy-mm-dd" data-auto-close="true" id="end" name="end">
                        </div>

                        <div class="form-group col-md-6" id="end_time_div">
                            <label for="end_time">{$_L['End Time']}</label>
                            <input type="text" class="form-control" id="end_time" {if $event && $event->end}value="{date('h:ia',strtotime($event->end))}" {else} value="11:30am" {/if} name="end_time">
                        </div>
                    </div>



                    <div class="form-group">

                        <input class="custom-checkbox" type="checkbox" name="all_day_event" value="yes" id="all_day_event">
                        <label for="all_day_event">{$_L['All day event']}</label>


                    </div>


                    <div class="form-group">
                        <label for="color">{$_L['Color']}</label>
                        <input type="color" class="form-control color" id="color" name="color" value="#2196f3" style="max-width: 100px;">
                    </div>


                    <div class="form-group">
                        <label for="description">{$_L['Description']}</label>
                        <textarea id="description" name="description" class="form-control" rows="5"></textarea>
                    </div>

                    {if $event}
                        <input type="hidden" id="event_id" name="event_id" value="{$event->id}">
                    {/if}



                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" id="btnSubmit">{$_L['Save']}</button>
                        {if $event}
                            <a class="btn btn-danger" href="{$_url}calendar/delete-event/{$event->id}">{$_L['Delete']}</a>
                        {/if}
                    </div>



                </form>

            </div>
        </div>
    </div>
</div>


