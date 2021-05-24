import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:flutter/services.dart';
import 'package:google_events_io/secrets/secret.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screens/screen_home.dart';
import 'services/service_events.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
  }
  WidgetsFlutterBinding.ensureInitialized();

  var _clientID = new ClientId(Secret.ANDROID_API_KEY, "");
  const _scopes = const [calendar.CalendarApi.calendarScope];
  await clientViaUserConsent(_clientID, _scopes, prompt)
      .then((AuthClient client) async {
    EventService.calendarApi = calendar.CalendarApi(client);
  });

  runApp(EventsIO());
}

void prompt(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class EventsIO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Events IO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
        ),
      ),
      home: Home(),
    );
  }
}
