import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/screens/edit_profile_screen.dart';
import 'package:parking_system/screens/generateQR_screen.dart';
import 'package:parking_system/screens/login_screen.dart';
import 'package:parking_system/screens/signup_payment.dart';
import 'package:parking_system/screens/updateInfo_screen.dart';
import 'package:parking_system/screens/signup_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'screens/home_screen.dart';
import 'screens/map_screen.dart';

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
/*
class splashscreen extends StatelessWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
    );
  }
}
*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390.0, 845.13),
      builder: () => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF08051F)),
          //initialRoute: LoginScreen.id,
          home: AnimatedSplashScreen(
            splash: Column(
                children:[
                Center(child: Image.asset('images/parking_img.png',width: 400,height: 30,)),
                  const Text('El Sayes App',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),)
              ],
            ),
            backgroundColor: Color(0xFF08051F),
            splashTransition: SplashTransition.fadeTransition,
            nextScreen: LoginScreen(),
            duration: 2000,
          ),
          routes: {
            HomeScreen.id: (context) => HomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            MapPage.id: (context) => MapPage(),
            SignupPayment.id: (context) => SignupPayment(),
            SignupScreen.id: (context) => SignupScreen(),
            GenerateQRScreen.id: (context) => GenerateQRScreen(),
            EditProfilePage.id: (context) => EditProfilePage(),
            UpdateInfo.id: (context) => UpdateInfo(),

          }),
    );
  }
}
