import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signup_payment.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390.0,845.13),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme:  ThemeData(scaffoldBackgroundColor: const Color(0xFF08051F)),

        home: LoginScreen(),
      ),
    );
  }
}


