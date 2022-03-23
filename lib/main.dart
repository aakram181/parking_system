import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/screens/login_screen.dart';
import 'package:parking_system/screens/signup_payment.dart';
import 'package:parking_system/screens/signup_screen.dart';

import 'screens/home_screen.dart';
import 'screens/map_page.dart';

bool EMULATOR = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (EMULATOR) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390.0, 845.13),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF08051F)),
        initialRoute: LoginScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          MapPage.id: (context) => MapPage(),
          SignupPayment.id: (context) => SignupPayment(),
          SignupScreen.id: (context) => SignupScreen(),


        }

      ),
    );
  }
}
