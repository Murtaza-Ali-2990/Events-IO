import 'package:flutter/material.dart';

final fieldHeadingStyle = TextStyle(
  color: Colors.blue,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);

final buttonStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);

final fieldHeadingTextSpan = TextSpan(
  text: '*',
  style: TextStyle(
    color: Colors.red,
    fontSize: 28,
  ),
);

final textFieldStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);

final disabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.blue, width: 1),
);

final enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.blue, width: 1),
);

final focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.blue, width: 2),
);

final errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.redAccent, width: 2),
);

final simpleBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);

final contentPadding = EdgeInsets.all(16);

final hintStyle = TextStyle(
  color: Colors.grey.withOpacity(0.6),
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);

final errorStyle = TextStyle(
  fontSize: 12,
  color: Colors.redAccent,
);

final modelTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25,
);

final headingStyle = TextStyle(
  color: Colors.blue,
  fontSize: 30,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);
