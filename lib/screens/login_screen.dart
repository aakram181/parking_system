import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/screens/signup_screen.dart';
import 'package:parking_system/utils/constants.dart';
import '../widgets/textbox.dart';
import '../widgets/main_button.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text(
                'Smart Parking',
                style: kTitleTextStyle,
              ),
              Image.asset('images/parking_img.png'),

              TextBox(labelText : 'Username*',icon: Icons.account_circle_outlined),
                  SizedBox(
                    height:20.0.h,
                  ),
              TextBox(labelText: 'Password*', icon: Icons.password, obscureText: true,),

              SizedBox(
                    height:20.0.h,
                  ),

              mainButton(text: 'Log in', onPressed: (){},),

              SizedBox(
                    height:20.0.h,
                  ),

              Text.rich(
                      TextSpan(
                          text: 'Not registered yet? ',
                  style: kSubTitleTextStyle,
                      children: [
                        TextSpan(text: 'Register',
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SignupScreen();
                          }));
                            },
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ))
                      ]))
            ]),
          ),
        ),
      ),
    );
  }
}




