import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/users/login_register/loginpage.dart';
import 'package:drawer/screens/users/orders_screen/orders_screen.dart';
import 'package:drawer/screens/users/profile_Screen/component/card_details.dart';
import 'package:drawer/screens/users/profile_Screen/component/edit_detail.dart';
import 'package:drawer/services/auth_hepler.dart';
import 'package:drawer/services/firestore_services.dart';
import 'package:drawer/screens/users/user_widget/bg_widget.dart';
import 'package:drawer/screens/users/user_widget/lish.dart';
import 'package:drawer/screens/users/wishlist_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    firestoreService.getCount();

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
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

            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDetail(data: data),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // Check if image URL is valid
                        data['imageurl'] == null || data['imageurl'] == ''
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'] ?? 'No Name',
                                style: const TextStyle(
                                  fontFamily: semibold,
                                  color: whiteColor,
                                ),
                              ),
                              Text(
                                data['email'] ?? 'No Email',
                                style: const TextStyle(color: whiteColor),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: whiteColor),
                          ),
                          onPressed: () async {
                            await AuthenticationHelper().signout();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontFamily: semibold,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: firestoreService.getCount(),
                      builder:
                          (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cartDetails(
                                count: countData[0].toString(),
                                title: 'In your Cart',
                                width: 120,
                                height: 60,
                              ),
                              cartDetails(
                                count: countData[2].toString(),
                                title: 'In your Order',
                                width: 120,
                                height: 60,
                              ),
                              cartDetails(
                                count: countData[1].toString(),
                                title: 'In Your Wishlist',
                                width: 120,
                                height: 60,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        itemCount: profileButtonList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index >= profileButtonList.length ||
                              index >= profileButtonIcon.length) {
                            return const SizedBox();
                          }
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OrdersScreem(),
                                    ),
                                  );
                                  break;
                                case 1:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WishlistScreen(),
                                    ),
                                  );
                                  break;
                                default:
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileButtonIcon[index],
                              width: 22,
                              color: darkFontGrey,
                            ),
                            title: Text(
                              profileButtonList[index],
                              style: const TextStyle(
                                color: darkFontGrey,
                                fontFamily: semibold,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
