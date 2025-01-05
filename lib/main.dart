import 'package:drawer/screens/splash_screen.dart';
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
    );
  }
}
