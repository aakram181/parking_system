import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/utils/constants.dart';
import '../widgets/textbox.dart';
import '../widgets/main_button.dart';
import 'signup_payment.dart';
class SignupScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.only(left: 20.0, right :  20.0,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sign up',
                    style: kTitleTextStyle,
                    textAlign: TextAlign.left,),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Fill in your registeration details',
                    style: kSubTitleTextStyle,),
                  ),
                  SizedBox(
                    height:20.0.h,
                  ),

                  TextBox(labelText : 'Username', icon: Icons.account_circle_outlined),
                  SizedBox(
                    height:20.0.h,
                  ),
                  TextBox(labelText : 'Password', icon: Icons.password, obscureText: true,),
                  SizedBox(
                    height:20.0.h,
                  ),
                  TextBox(labelText : 'Email', icon: Icons.email, textInputType:TextInputType.emailAddress,),
                  SizedBox(
                    height:20.0.h,
                  ),
                  TextBox(labelText : 'License plate no.', icon: Icons.directions_car),
                  SizedBox(
                    height:50.0.h,
                  ),
                  mainButton(text: 'Next', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SignupPayment();
                    }));
                  }),




                ]
              ),
            )
          ),
        ),
    );
  }
}
