import 'package:flutter/material.dart';
import 'package:google_events_io/models/designs.dart';
import 'package:google_events_io/services/service_events.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:intl/intl.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController textControllerDate;
  TextEditingController textControllerStartTime;
  TextEditingController textControllerEndTime;
  TextEditingController textControllerTitle;
  TextEditingController textControllerDesc;
  TextEditingController textControllerLocation;

  FocusNode textFocusNodeTitle;
  FocusNode textFocusNodeDesc;
  FocusNode textFocusNodeLocation;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  String currentTitle;
  String currentDesc;
  String currentLocation;
  String errorString = '';

  bool isEditingDate = false;
  bool isEditingStartTime = false;
  bool isEditingEndTime = false;
  bool isEditingTitle = false;
  bool isErrorTime = false;

  bool isBeingUploaded = false;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textControllerDate.text = DateFormat.yMMMMd().format(selectedDate);
      });
    }
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    } else {
      setState(() {
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    } else {
      setState(() {
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    }
  }

  String _validateTitle(String value) {
    if (value != null) {
      value = value?.trim();
      if (value.isEmpty) {
        return 'Title can\'t be empty';
      }
    } else {
      return 'Title can\'t be empty';
    }

    return null;
  }

  @override
  void initState() {
    textControllerDate = TextEditingController();
    textControllerStartTime = TextEditingController();
    textControllerEndTime = TextEditingController();
    textControllerTitle = TextEditingController();
    textControllerDesc = TextEditingController();
    textControllerLocation = TextEditingController();

    textFocusNodeTitle = FocusNode();
    textFocusNodeDesc = FocusNode();
    textFocusNodeLocation = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Create Event',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Select Date',
                        style: fieldHeadingStyle,
                        children: <TextSpan>[
                          fieldHeadingTextSpan,
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: textControllerDate,
                      textCapitalization: TextCapitalization.characters,
                      onTap: () => _selectDate(context),
                      readOnly: true,
                      style: textFieldStyle,
                      decoration: new InputDecoration(
                        disabledBorder: disabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        border: simpleBorder,
                        contentPadding: contentPadding,
                        hintText: 'eg: September 10, 2020',
                        hintStyle: hintStyle,
                        errorText:
                            isEditingDate && textControllerDate.text != null
                                ? textControllerDate.text.isNotEmpty
                                    ? null
                                    : 'Date can\'t be empty'
                                : null,
                        errorStyle: errorStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Start Time',
                        style: fieldHeadingStyle,
                        children: <TextSpan>[
                          fieldHeadingTextSpan,
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: textControllerStartTime,
                      onTap: () => _selectStartTime(context),
                      readOnly: true,
                      style: textFieldStyle,
                      decoration: new InputDecoration(
                        disabledBorder: disabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        border: simpleBorder,
                        contentPadding: contentPadding,
                        hintText: 'eg: 09:30 AM',
                        hintStyle: hintStyle,
                        errorText: isEditingStartTime &&
                                textControllerStartTime.text != null
                            ? textControllerStartTime.text.isNotEmpty
                                ? null
                                : 'Start time can\'t be empty'
                            : null,
                        errorStyle: errorStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'End Time',
                        style: fieldHeadingStyle,
                        children: <TextSpan>[
                          fieldHeadingTextSpan,
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: textControllerEndTime,
                      onTap: () => _selectEndTime(context),
                      readOnly: true,
                      style: textFieldStyle,
                      decoration: new InputDecoration(
                        disabledBorder: disabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        border: simpleBorder,
                        contentPadding: contentPadding,
                        hintText: 'eg: 11:30 AM',
                        hintStyle: hintStyle,
                        errorText: isEditingEndTime &&
                                textControllerEndTime.text != null
                            ? textControllerEndTime.text.isNotEmpty
                                ? null
                                : 'End time can\'t be empty'
                            : null,
                        errorStyle: errorStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Title',
                        style: fieldHeadingStyle,
                        children: <TextSpan>[
                          fieldHeadingTextSpan,
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      enabled: true,
                      focusNode: textFocusNodeTitle,
                      controller: textControllerTitle,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          isEditingTitle = true;
                          currentTitle = value;
                        });
                      },
                      onSubmitted: (value) {
                        textFocusNodeTitle.unfocus();
                        FocusScope.of(context).requestFocus(textFocusNodeDesc);
                      },
                      style: textFieldStyle,
                      decoration: new InputDecoration(
                        disabledBorder: disabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        border: simpleBorder,
                        contentPadding: contentPadding,
                        hintText: 'Subject',
                        hintStyle: hintStyle,
                        errorText: isEditingTitle
                            ? _validateTitle(currentTitle)
                            : null,
                        errorStyle: errorStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Description',
                        style: fieldHeadingStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      enabled: true,
                      maxLines: null,
                      focusNode: textFocusNodeDesc,
                      controller: textControllerDesc,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          currentDesc = value;
                        });
                      },
                      onSubmitted: (value) {
                        textFocusNodeDesc.unfocus();
                        FocusScope.of(context)
                            .requestFocus(textFocusNodeLocation);
                      },
                      style: textFieldStyle,
                      decoration: new InputDecoration(
                        disabledBorder: disabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        border: simpleBorder,
                        contentPadding: contentPadding,
                        hintText: 'Description',
                        hintStyle: hintStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Location',
                        style: fieldHeadingStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      enabled: true,
                      focusNode: textFocusNodeLocation,
                      controller: textControllerLocation,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          currentLocation = value;
                        });
                      },
                      onSubmitted: (value) {
                        textFocusNodeLocation.unfocus();
                        FocusScope.of(context)
                            .requestFocus(textFocusNodeLocation);
                      },
                      style: textFieldStyle,
                      decoration: new InputDecoration(
                        disabledBorder: disabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        border: simpleBorder,
                        contentPadding: contentPadding,
                        hintText: 'Location',
                        hintStyle: hintStyle,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: _addToGoogleCalendar,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: isBeingUploaded
                              ? SizedBox(
                                  height: 28,
                                  width: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                )
                              : Text(
                                  'ADD',
                                  style: buttonStyle,
                                ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isErrorTime,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(errorString, style: errorStyle),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _addToGoogleCalendar() async {
    if (isBeingUploaded) return;
    setState(() {
      isErrorTime = false;
      isBeingUploaded = true;
    });

    textFocusNodeTitle.unfocus();
    textFocusNodeDesc.unfocus();
    textFocusNodeLocation.unfocus();

    if (selectedDate != null &&
        selectedStartTime != null &&
        selectedEndTime != null &&
        currentTitle != null) {
      DateTime startDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedStartTime.hour,
        selectedStartTime.minute,
      );
      int startTimeInEpoch = startDateTime.millisecondsSinceEpoch;

      DateTime endDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedEndTime.hour,
        selectedEndTime.minute,
      );
      int endTimeInEpoch = endDateTime.millisecondsSinceEpoch;

      if (endTimeInEpoch - startTimeInEpoch > 0) {
        if (_validateTitle(currentTitle) == null) {
          calendar.Event event = calendar.Event();
          event.summary = currentTitle;

          calendar.EventDateTime start = new calendar.EventDateTime();
          start.dateTime = startDateTime;
          start.timeZone = "GMT+05:30";
          event.start = start;

          calendar.EventDateTime end = new calendar.EventDateTime();
          end.dateTime = endDateTime;
          end.timeZone = "GMT+05:30";
          event.end = end;

          event.description = currentDesc ?? '';
          event.location = currentLocation ?? '';

          await _insertEvent(event);
          Navigator.of(context).pop();

          setState(() {
            isBeingUploaded = false;
          });
        } else {
          setState(() {
            isEditingTitle = true;
          });
        }
      } else {
        setState(() {
          isErrorTime = true;
          errorString = 'Invalid time! Please use a proper start and end time';
        });
      }
    } else {
      setState(() {
        isEditingDate = true;
        isEditingStartTime = true;
        isEditingEndTime = true;
        isEditingTitle = true;
      });
    }
    setState(() {
      isBeingUploaded = false;
    });
  }

  Future _insertEvent(calendar.Event event) async {
    try {
      var calendarApi = EventService.calendarApi;
      String calendarId = "primary";
      await calendarApi.events.insert(event, calendarId).then((value) {
        if (value.status == "confirmed") {
          print('Event added in google calendar');
        } else {
          print("Unable to add event in google calendar");
        }
      });
    } catch (e) {
      print('Error creating event $e');
    }
  }
}
