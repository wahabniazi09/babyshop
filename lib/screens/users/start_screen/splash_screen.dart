import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/admin/admin_home.dart';
import 'package:drawer/screens/users/login_register/loginpage.dart';
import 'package:drawer/screens/users/Home_Screen/home.dart';
import 'package:drawer/services/auth_hepler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void onChangedScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) async {
        if (user == null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          // Fetch user role from Firestore
          DocumentSnapshot userDoc = await firestore
              .collection(userCollection)
              .doc(user!.uid)
              .get();

          if (userDoc.exists) {
            String role = userDoc['role']; // Get role from Firestore

            if (role == 'Admin') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AdminHome()));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            }
          }
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    onChangedScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(babyimg),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 250,
              color: Colors.redAccent,
            ),
            Text(
              'Baby Shop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
