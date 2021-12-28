import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
class mainButton extends StatelessWidget {

  final String text;
  final Function() onPressed;

  mainButton({required this.text,required this.onPressed});
  final button_width = 150.w;
  final button_height = 50.h;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        backgroundColor: kButtonColor,
        fixedSize: Size(button_width,button_height),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: kButtonTextStyle,),
    );
  }
}