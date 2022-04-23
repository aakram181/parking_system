import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

String selectedCardID = '0';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

enum ParkState { empty, occupied, reserved, unknown }
enum TransactionStatus { ongoing, complete }

TextStyle kSelectedTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 40.0.sp,
  fontWeight: FontWeight.w700,
  color: Colors.green,
);

TextStyle kReservedTextStyle = const TextStyle(
  fontFamily: 'Roboto',
  fontSize: 0.5,
  fontWeight: FontWeight.w700,
  color: Colors.yellow,
);

TextStyle kListItemStyle = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 15.0.sp,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

TextStyle kButtonTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 25.0.sp,
    color: Colors.white,
    fontWeight: FontWeight.w700);

TextStyle kTitleTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 40.0.sp,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

TextStyle kSubTitleTextStyle = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22.0.sp,
  color: Colors.white,
);

Color kButtonColor = Color(0xFF137EA0);
