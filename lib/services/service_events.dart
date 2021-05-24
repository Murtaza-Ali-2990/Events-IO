import 'package:googleapis/calendar/v3.dart';

class EventService {
  static CalendarApi calendarApi;

  static Stream<List<Event>> get events {
    print('update');
    return calendarApi.events.list('primary').asStream().map((events) {
      final List<Event> eventList = <Event>[];
      if (events != null && events.items != null) {
        for (Event event in events.items) {
          if (event.start == null) {
            continue;
          }
          eventList.add(event);
        }
      }
      return eventList;
    });
  }
}
