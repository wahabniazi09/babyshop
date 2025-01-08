import 'package:drawer/firebase_options.dart';
import 'package:drawer/routes/pages_routes.dart';
import 'package:drawer/screens/admin/admin_screen.dart';
import 'package:drawer/screens/login_register/loginpage.dart';
import 'package:drawer/screens/start_screen/onboardscreen.dart';
import 'package:drawer/screens/login_register/registerpage.dart';
import 'package:drawer/screens/start_screen/splash_screen.dart';
import 'package:drawer/screens/start_screen/splashlogin.dart';
import 'package:drawer/screens/users/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        PageRoutes.loginpage : (context) => const LoginPage(),
        PageRoutes.registerpage : (context) => const RegisterPage(),
        PageRoutes.onboardscreen : (context) =>  Onboardscreen(),
        PageRoutes.splashlogin : (context) => const Splashlogin(),
        PageRoutes.splashscreen : (context) => const SplashScreen(),
        PageRoutes.userscreen : (context) => const UserScreen(),
        PageRoutes.adminscreen : (context) => const AdminScreen(),
      },
    );
  }
}
