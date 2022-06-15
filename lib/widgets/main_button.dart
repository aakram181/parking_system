import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
class mainButton extends StatelessWidget {

  final String text;
  final Function() onPressed;
  final Color color;

  mainButton({required this.text,required this.onPressed, this.color:  kButtonColor});
  final button_width = 250.w;
  final button_height = 50.h;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        backgroundColor: color,
        fixedSize: Size(button_width,button_height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: kButtonTextStyle,),
    );
  }
}