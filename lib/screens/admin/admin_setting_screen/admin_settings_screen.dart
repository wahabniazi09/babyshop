import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/colors.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/admin/admin_setting_screen/admin_edit_screen.dart';
import 'package:drawer/screens/users/login_register/loginpage.dart';
import 'package:drawer/screens/users/user_widget/lish.dart';
import 'package:drawer/services/auth_hepler.dart';
import 'package:drawer/services/firestore_services.dart';
import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestoreService.getUser(currentUser?.uid ?? ''),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          }

          // Check if no data is available
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No data available for this user",
                style: TextStyle(color: darkFontGrey, fontSize: 16),
              ),
            );
          }

          // Fetch the first document
          var data = snapshot.data!.docs[0];
          return Scaffold(
            backgroundColor: Colors.deepPurple[900],
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 16.0, color: whiteColor),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdminEditScreen(data: data)));
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: whiteColor,
                    )),
                TextButton(
                  onPressed: () async {
                    await AuthenticationHelper().signout();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: whiteColor),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                ListTile(
                  leading: data['imageurl'] == null || data['imageurl'] == ''
                      ? ClipOval(
                          child: Image.asset(
                            imgS1,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.memory(
                            base64Decode(data['imageurl']),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                  title: Text(
                    "${data['name'] ?? 'No Name'}",
                    style: const TextStyle(color: whiteColor, fontFamily: bold),
                  ),
                  subtitle: Text("${data['email'] ?? 'No Email'}",
                      style:
                         const TextStyle(color: whiteColor, fontFamily: semibold)),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
                        AdminButtonList.length,
                        (index) => ListTile(
                              leading: Icon(
                                AdminButtonIcon[index],
                                color: whiteColor,
                              ),
                              title: Text(
                                AdminButtonList[index],
                                style: TextStyle(color: whiteColor),
                              ),
                            )),
                  ),
                )
              ],
            ),
          );
        });
  }
}
