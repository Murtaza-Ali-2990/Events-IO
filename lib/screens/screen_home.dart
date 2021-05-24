import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_events_io/models/model_calendar.dart';
import 'package:google_events_io/screens/screen_add_event.dart';
import 'package:google_events_io/services/service_events.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Events IO'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateEvent()));
                setState(() {});
              }),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: StreamProvider<List<Event>>.value(
        value: EventService.events,
        initialData: <Event>[],
        child: CalendarModel(),
      ),
    );
  }
}
