import 'package:flutter/material.dart';
import 'package:google_events_io/models/model_appointment_list.dart';
import 'package:google_events_io/models/model_event_data.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarModel extends StatefulWidget {
  _CalendarModelState createState() => _CalendarModelState();
}

class _CalendarModelState extends State<CalendarModel> {
  List<Event> events;

  Widget build(BuildContext context) {
    events = Provider.of<List<Event>>(context);

    return Container(
      margin: EdgeInsets.all(10.0),
      child: SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(events: events),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        onTap: (tapDetails) {
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, _, __) => Material(
                    type: MaterialType.transparency,
                    child: AppointmentList(
                        appointmentList: tapDetails.appointments,
                        selectedDate: tapDetails.date),
                  ),
              fullscreenDialog: true));
        },
      ),
    );
  }
}
