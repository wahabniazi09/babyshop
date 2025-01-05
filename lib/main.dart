import 'package:drawer/routes/pages_routes.dart';
import 'package:drawer/screens/home_screen.dart';
import 'package:drawer/screens/loginpage.dart';
import 'package:drawer/screens/onboardscreen.dart';
import 'package:drawer/screens/registerpage.dart';
import 'package:drawer/screens/splash_screen.dart';
import 'package:drawer/screens/splashlogin.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const BabyApp());
}

class  BabyApp extends StatelessWidget {
  const  BabyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: const SplashScreen(),
      routes: {
        PageRoutes.loginpage : (context) => const Loginpage(),
        PageRoutes.registerpage : (context) => const RegisterPage(),
        PageRoutes.onboardscreen : (context) =>  Onboardscreen(),
        PageRoutes.splashlogin : (context) => const Splashlogin(),
        PageRoutes.splashscreen : (context) => const SplashScreen(),
        PageRoutes.homepage : (context) => const HomeScreen(),
      },
    );
  }
}
