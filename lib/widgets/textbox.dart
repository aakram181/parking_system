import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';

class TextBox extends StatelessWidget {

  final String labelText;
  final IconData icon;
  final bool obscureText;
  final int maxLength;
  final TextInputType textInputType;
  TextBox({ required this.labelText, required this.icon, this.obscureText = false,  this.textInputType= TextInputType.text, this.maxLength = 100,});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.8.sw,
      child: TextFormField(
        maxLength: maxLength,
        keyboardType: textInputType,
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
            suffixIcon: Icon(icon, color: kButtonColor),
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kButtonColor,),
            )
        ),

      ),
    );
  }
}