import 'package:drawer/routes/pages_routes.dart';
import 'package:drawer/services/auth_hepler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  static const String routeName = "/UserPage";

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, PageRoutes.loginpage);
    } else {
      setState(() {
        uid = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("User Panel"), backgroundColor: Colors.redAccent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("this is User panel"),
              ElevatedButton(
                  onPressed: () async {
                    await AuthenticationHelper().signOut();
                    Navigator.pushReplacementNamed(
                        context, PageRoutes.loginpage);
                  },
                  child: const Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }
}
