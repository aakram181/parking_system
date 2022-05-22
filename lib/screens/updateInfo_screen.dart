import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/screens/home_screen.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/utils/view_model.dart';

import '../utils/validators.dart';
import '../widgets/main_button.dart';
import '../widgets/textbox.dart';

class UpdateInfo extends StatefulWidget {
  static const String id = 'UpdateInfo_screen';

  @override
  _UpdateInfoState createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '',
                          style: kTitleTextStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Update your data',
                          style: kSubTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      TextBox(
                          labelText: 'Username',
                          icon: Icons.account_circle_outlined,
                          validator: Validator.validateUsername,
                          onSaved: (value) {
                            _username = value.toString();
                          }),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      TextBox(
                        labelText: 'Password',
                        icon: Icons.password,
                        obscureText: true,
                        validator: Validator.validatePassword,
                        onSaved: (value) {
                          _password = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      TextBox(
                        labelText: 'Email',
                        icon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        validator: Validator.validateEmail,
                        onSaved: (value) {
                          _email = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      mainButton(
                          text: 'Update',
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final bool isValid =
                                _formKey.currentState!.validate();
                            if (isValid) {
                              _formKey.currentState!.save();
                              ViewModel.updateInfo(
                                  _email,_password ,_username);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));
                            }
                            else {
                              SnackBar snackBar = const SnackBar(
                                  backgroundColor: Colors.blue,
                                  content:
                                      Text("Incorrect information provided"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }),
                    ]),
              ),
            )),
      ),
    );
  }
}
