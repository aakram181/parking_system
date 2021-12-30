import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int selectedCardID=0;

enum ParkState{
  empty,
  occupied
}

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

TextStyle kSubTitleTextStyle =TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22.0.sp,
  color: Colors.white,
);

TextStyle kSelectedTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 40.0.sp,
  fontWeight: FontWeight.w700,
  color: Colors.green,
);


Color kButtonColor = Color(0xFF137EA0);

