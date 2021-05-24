import 'package:flutter/material.dart';
import 'package:google_events_io/models/designs.dart';
import 'package:intl/intl.dart';

class AppointmentModel extends StatelessWidget {
  final event;
  AppointmentModel({@required this.event});

  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 1.2,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: event.summary,
                  style: headingStyle,
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Date: ',
                          style: fieldHeadingStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: DateFormat.yMMMMd()
                                    .format(event.start.dateTime),
                                style: modelTextStyle),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: 'Start Time: ',
                          style: fieldHeadingStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: DateFormat.jm()
                                    .format(event.start.dateTime),
                                style: modelTextStyle),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: 'End Time: ',
                          style: fieldHeadingStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    DateFormat.jm().format(event.end.dateTime),
                                style: modelTextStyle),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      if (event.description != null &&
                          event.description.isNotEmpty)
                        RichText(
                          text: TextSpan(
                            text: 'Description: ',
                            style: fieldHeadingStyle,
                            children: <TextSpan>[
                              TextSpan(
                                text: event.description,
                                style: modelTextStyle,
                              ),
                            ],
                          ),
                        ),
                      if (event.description != null &&
                          event.description.isNotEmpty)
                        SizedBox(height: 15),
                      if (event.location != null && event.location.isNotEmpty)
                        RichText(
                          text: TextSpan(
                            text: 'Location: ',
                            style: fieldHeadingStyle,
                            children: <TextSpan>[
                              TextSpan(
                                text: event.location,
                                style: modelTextStyle,
                              ),
                            ],
                          ),
                        ),
                      if (event.location != null && event.location.isNotEmpty)
                        SizedBox(height: 15),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
