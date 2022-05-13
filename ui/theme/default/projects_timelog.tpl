{extends file="project_base.tpl"}


{block name="project_content"}


    <div style="min-height: 400px;" id="calendar_wrap">
        <div id="calendar"></div>
    </div>

    <div id="modal_add_event" data-backdrop="static" class="modal fade-scale" tabindex="-1" data-width="800" style="display: none;">
        <form id="ib_modal_form">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="modal_title">{$_L['Add Event']}</h4>
            </div>
            <div class="modal-body">
                <div class="row">





                    <div class="form-group col-md-12">
                        <label for="title">{$_L['Event Name']}</label>
                        <input type="text" class="form-control" id="title" name="title" value="" required>
                    </div>



                    <div class="form-group col-md-6">
                        <label for="start">{$_L['Start Date']}</label>
                        <input type="text" class="form-control" datepicker data-date-format="yyyy-mm-dd" data-auto-close="true" id="start" placeholder="Select Date" name="start" value="{$mdate}">
                    </div>

                    <div class="form-group col-md-6" id="start_time_div">
                        <label for="start_time">{$_L['Start Time']}</label>
                        <div class="input-group">

                            <input type="text" id="start_time" name="start_time" class="form-control" value="09:30am">

                            <span class="input-group-addon" id="start_time_picker_icon"><span class="glyphicon glyphicon-time"></span></span>
                        </div>
                    </div>



                    <div class="form-group col-md-6">
                        <label for="end">{$_L['End Date']}</label>
                        <input type="text" class="form-control" datepicker data-date-format="yyyy-mm-dd" data-auto-close="true" id="end" name="end" value="">
                    </div>

                    <div class="form-group col-md-6" id="end_time_div">
                        <label for="end_time">{$_L['End Time']}</label>
                        <div class="input-group">

                            <input type="text" class="form-control" id="end_time" name="end_time" value="11:30am">
                            <span class="input-group-addon" id="end_time_picker_icon"><span class="glyphicon glyphicon-time"></span></span>
                        </div>
                    </div>



                    <div class="form-group col-md-12">

                        <input class="i-checks" type="checkbox" name="all_day_event" value="yes" id="all_day_event">
                        <label for="all_day_event">{$_L['All day event']}</label>


                    </div>


                    <div class="form-group col-md-12">
                        <label for="color">{$_L['Color']}</label>
                        <input type="text" class="form-control color" id="color" name="color" value="#2196f3">
                    </div>


                    <div class="form-group col-md-12">
                        <label for="description">{$_L['Description']}</label>
                        <textarea id="description" name="description" class="form-control" rows="5"></textarea>
                    </div>



                    <input type="hidden" id="ib_act" name="ib_act" value="create">
                    <input type="hidden" id="event_id" name="event_id" value="0">






                </div>
            </div>
            <div class="modal-footer">
                <a href="#" id="btn_del_event" class="btn btn-danger"><i class="fal fa-trash"></i> {$_L['Delete']}</a>
                <button type="button" data-dismiss="modal" class="btn btn-warning">{$_L['Close']}</button>
                <button type="submit" id="btn_save_event" class="btn btn-primary">{$_L['Submit']}</button>
            </div>
        </form>
    </div>

    <div class="md-fab-wrapper">
        <a class="md-fab md-fab-primary waves-effect waves-light add_event" href="#">
            <i class="fal fa-plus"></i>
        </a>
    </div>

{/block}

{block name="script"}



    <script>

        function displayEvent(event_id=0,date=0)
        {
            $.fancybox.open({
                src  :  base_url + 'calendar/event/'+event_id+'/'+date,
                type : 'ajax',
                opts : {
                    afterShow : function( instance, current ) {
                        // $('[data-toggle="datepicker"]').datepicker();
                        // $start_time.timepicker();
                        // $end_time.timepicker();

                        $('#start').datepicker();
                        $('#start_time').timepicker();
                        $('#end').datepicker();

                        let eventForm = $('#eventForm');
                        eventForm.on('submit',function (e) {
                            e.preventDefault();
                            $.post( base_url + "calendar/save_event/", eventForm.serialize())
                                .done(function( data ) {



                                    if ($.isNumeric(data)) {

                                        location.reload();

                                    }

                                    else {
                                        toastr.error(data);
                                    }

                                });


                            return false;
                        });

                    }
                },
            });
        }

        $(function() {

            var _url = $("#_url").val();

            var $calendar_wrap = $("#calendar_wrap");

            // var ib_date_picker_options = {
            //     format: ib_date_format_picker
            // };


            var $modal = $("#modal_add_event");

            var $ib_modal_form = $("#ib_modal_form");

            var $start = $('#start');

            // var start_picker = $start.pickadate(ib_date_picker_options);
            // var picker = start_picker.pickadate('picker');

            var $ib_act = $("#ib_act");
            var $event_id = $("#event_id");

            var $end = $('#end');

            // var end_picker = $end.pickadate(ib_date_picker_options);
            // var picker2 = end_picker.pickadate('picker');

            var $description = $("#description");
            var $title = $("#title");

            var $all_day_event = $("#all_day_event");

            var $start_time_div = $("#start_time_div");
            var $end_time_div = $("#end_time_div");

            var $btn_del_event = $("#btn_del_event");

            var $start_time = $('#start_time');
            var $end_time = $('#end_time');

            $btn_del_event.hide();

            $btn_del_event.on('click', function(e) {

                e.preventDefault();

                bootbox.confirm(_L['are_you_sure'], function(result) {

                    if(result){

                        window.location.href = _url + "delete/event/" + $event_id.val();

                    }

                });

            });


            var todayDate = moment().startOf('day');
            var YM = todayDate.format('YYYY-MM');
            var YESTERDAY = todayDate.clone().subtract(1, 'day').format('YYYY-MM-DD');
            var TODAY = todayDate.format('YYYY-MM-DD');
            var TOMORROW = todayDate.clone().add(1, 'day').format('YYYY-MM-DD');


            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl,
                {
                    plugins: ['dayGrid', 'list', 'timeGrid', 'interaction', 'bootstrap'],
                    themeSystem: 'bootstrap',
                    timeZone: 'UTC',
                    defaultView: 'timeGridDay',
                    //dateAlignment: "month", //week, month
                    buttonText:
                        {
                            today: 'today',
                            month: 'month',
                            week: 'week',
                            day: 'day',
                            list: 'list'
                        },
                    eventTimeFormat:
                        {
                            hour: 'numeric',
                            minute: '2-digit',
                            meridiem: 'short'
                        },
                    navLinks: true,
                    header:
                        {
                            left: 'title',
                            center: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek',
                            right: 'today prev,next'
                        },
                    footer:
                        {
                            left: '',
                            center: '',
                            right: ''
                        },
                    editable: true,
                    eventLimit: true, // allow "more" link when too many events
                    eventSources: [{
                        url: base_url + 'calendar/data/',
                        type: 'GET',
                        error: function() {
                            bootbox.alert("Unable to load data.");
                        }
                    } ],
                    viewSkeletonRender: function()
                    {
                        $('.fc-toolbar .btn-default').addClass('btn-sm');
                        $('.fc-header-toolbar h2').addClass('fs-md');
                        $('#calendar').addClass('fc-reset-order')
                    },

                    dateClick: function(info) {
                        displayEvent(0,info.dateStr);
                    },
                    eventClick: function(info) {
                        displayEvent(info.event.id);
                    }


                });

            calendar.render();



            $all_day_event.on('ifChecked', function(){

                $start_time_div.hide("slow");
                $end_time_div.hide("slow");

            });

            $all_day_event.on('ifUnchecked', function(){

                $start_time_div.show("slow");
                $end_time_div.show("slow");

            });



            $(".add_event").on('click', function(e) {
                e.preventDefault();

                displayEvent();

            });





        });



    </script>

{/block}
