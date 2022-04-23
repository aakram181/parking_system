import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/screens/home_screen.dart';
import 'package:parking_system/screens/signup_screen.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/utils/validators.dart';
import 'package:parking_system/utils/view_model.dart';

import '../widgets/main_button.dart';
import '../widgets/textbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<bool> _login(String email, String pwd) async {
    return ViewModel.login(email, pwd);
  }

  @override
  Widget build(BuildContext context) {
    SnackBar snackBar;
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
                            final value = await _login(email, password);
                            if (value == true) {
                              snackBar = const SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text("Login Successfully"));

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HomeScreen();
                              }));
                            } else {
                              snackBar = const SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text("Incorrect Email or Password"));
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const SignupScreen();
                                  }));
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
