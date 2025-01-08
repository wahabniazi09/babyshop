import 'package:drawer/routes/pages_routes.dart';
import 'package:drawer/services/auth_hepler.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
  static const String routeName = "/UserPage";

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
