import 'package:drawer/routes/pages_routes.dart';
import 'package:drawer/services/auth_hepler.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});
  static const String routeName = "/AdminPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Admin Panel"), backgroundColor: Colors.redAccent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("this is admin panel"),
              ElevatedButton(
                  onPressed: () async {
                    await AuthenticationHelper().signOut();
                    Navigator.pushReplacementNamed(context, PageRoutes.loginpage);
                  },
                  child: const Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }
}
