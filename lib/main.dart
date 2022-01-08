import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/screens/map_page.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signup_payment.dart';
import 'screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        theme:  ThemeData(scaffoldBackgroundColor: const Color(0xFF08051F)),

        home: LoginScreen(),
      ),
    );
  }
}


