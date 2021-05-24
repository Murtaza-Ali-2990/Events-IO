import 'package:flutter/material.dart';
import 'package:google_events_io/models/designs.dart';
import 'package:google_events_io/models/model_appointment.dart';
import 'package:intl/intl.dart';

class AppointmentList extends StatelessWidget {
  final List<dynamic> appointmentList;
  final DateTime selectedDate;
  AppointmentList(
      {@required this.appointmentList, @required this.selectedDate});

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
                text: TextSpan(
                  text: DateFormat.yMMMMd().format(selectedDate),
                  style: fieldHeadingStyle,
                ),
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2 * appointmentList.length,
                  itemBuilder: (context, index) {
                    if ((index & 1) == 1) return Divider();
                    index = index ~/ 2;
                    return ListTile(
                      title: Text(appointmentList[index].summary),
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (context, _, __) => Material(
                                  type: MaterialType.transparency,
                                  child: AppointmentModel(
                                    event: appointmentList[index],
                                  ),
                                ),
                            fullscreenDialog: true));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
