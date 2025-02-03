import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/admin/admin_product_screen/admin_product_details.dart';
import 'package:drawer/screens/admin/admin_widget/dashboard_button.dart';
import 'package:drawer/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: const Text(
            'Dashboard',
            style:
                TextStyle(fontFamily: bold, fontSize: 16, color: darkFontGrey),
          ),
          actions: [
            Text(intl.DateFormat('EEE, MMM d,' 'yy ').format(DateTime.now()))
          ],
        ),
        body: FutureBuilder(
            future: firestoreService.getFeaturedProducts(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(child: Text("No  products available"));
              }

              var allProducts = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: 'Products', count: '90', icon: icProducts),
                        dashboardButton(context,
                            title: 'Orders', count: '27', icon: icOrders),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: 'Total Sales',
                            count: '78888',
                            icon: icWholeSale),
                        dashboardButton(context,
                            title: 'Wishlist', count: '76', icon: icAdd)
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Popular Products',
                      style: TextStyle(
                          fontFamily: bold,
                          fontSize: 20.0,
                          color: darkFontGrey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: List.generate(
                          allProducts.length,
                          (index) => Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminProductDetails(
                                                    title:
                                                        "${allProducts[index]['p_name']}",
                                                    data: allProducts[index])));
                                  },
                                  leading: Image.memory(
                                      base64Decode(
                                          allProducts[index]['p_image'][0]),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover),
                                  title: Text(
                                    "${allProducts[index]['p_name']}",
                                    style: const TextStyle(
                                        color: fontGrey, fontFamily: bold),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "\$${allProducts[index]['p_price']}",
                                        style: const TextStyle(
                                            fontFamily: semibold,
                                            color: darkFontGrey),
                                      ),
                                      Text(
                                        "Featured",
                                        style: const TextStyle(
                                            fontFamily: semibold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              );
            }));
  }
}
