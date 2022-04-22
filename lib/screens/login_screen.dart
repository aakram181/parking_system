import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/repository/auth_repo.dart';
import 'package:parking_system/screens/home_screen.dart';
import 'package:parking_system/screens/signup_screen.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/utils/validators.dart';

import '../widgets/main_button.dart';
import '../widgets/textbox.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<bool> _login(String email, String pwd) async {
    bool isSuccess = false;
    await AuthRepo.signIn(email, pwd).then((uID) {
      if (uID != null) {
        print("Login Successful!"); // ToDo: Replace with snack bar
        // TODO: add spinner
        isSuccess = true;
      }
    });

    return isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      child: Text(
                        'Smart Parking',
                        style: kTitleTextStyle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('images/parking_img.png'),
                    ),
                    TextBox(
                      labelText: 'Email*',
                      icon: Icons.account_circle_outlined,
                      validator: Validator.notEmpty,
                      onSaved: (value) {
                        email = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    TextBox(
                      labelText: 'Password*',
                      icon: Icons.password,
                      validator: Validator.notEmpty,
                      obscureText: true,
                      onSaved: (value) {
                        password = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    mainButton(
                        text: 'Log in',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final bool isValid =
                              _formKey.currentState!.validate();
                          if (isValid) {
                            _formKey.currentState!.save();
                            print(email);
                            final value = await _login(email, password);

                            if (value == true) {
                              Navigator.pushNamed(context,
                                  HomeScreen.id);
                            } else {
                              // TODO: Snack bar
                              print("False Credentials!");
                            }
                          }
                        }),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    Text.rich(TextSpan(
                        text: 'Not registered yet? ',
                        style: kSubTitleTextStyle,
                        children: [
                          TextSpan(
                              text: 'Register',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context,
                                      SignupScreen.id);
                                },
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ))
                        ]))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
