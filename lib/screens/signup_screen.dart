import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/entities/car.dart';
import 'package:parking_system/entities/user.dart';
import 'package:parking_system/repository/auth_repo.dart';
import 'package:parking_system/repository/car_repo.dart';
import 'package:parking_system/repository/user_repo.dart';
import 'package:parking_system/screens/signup_payment.dart';
import 'package:parking_system/utils/constants.dart';

import '../utils/validators.dart';
import '../widgets/main_button.dart';
import '../widgets/textbox.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _email = '';
  String _plateNo = '';

  void _emailSignUp(String email, String password, String licensePlate,
      String username) async {
    await AuthRepo.signUp(email, password).then((uID) {
      if (uID != null) {
        Car car = Car(licensePlate: licensePlate, uID: uID);
        User user = User(uid: uID, email: email, username: username);
        CarRepo cRepo = CarRepo(car);
        cRepo.addCar();
        UserRepo uRepo = UserRepo(user);
        uRepo.addUser();
      }
    });
  }

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
                          'Sign up',
                          style: kTitleTextStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Fill in your registration details',
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
                      TextBox(
                        labelText: 'License plate no.',
                        icon: Icons.directions_car,
                        //validator: Validator.validateLicensePlate,
                        onSaved: (value) {
                          _plateNo = value.toString();
                          print(_plateNo);
                        },
                      ),
                      SizedBox(
                        height: 50.0.h,
                      ),
                      mainButton(
                          text: 'Next',
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final bool isValid =
                                _formKey.currentState!.validate();
                            if (isValid) {
                              _formKey.currentState!.save();
                              _emailSignUp(
                                  _email, _password, _plateNo, _username);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignupPayment();
                              }));
                            }
                          }),
                    ]),
              ),
            )),
      ),
    );
  }
}
