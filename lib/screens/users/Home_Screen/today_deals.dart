import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/colors.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/users/Category_Screen.dart/components/item_details.dart';
import 'package:drawer/services/firestore_services.dart';
import 'package:flutter/material.dart';

class TodayDeals extends StatelessWidget {
  const TodayDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Today Deal's",
              style: TextStyle(color: fontGrey, fontFamily: bold))),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<QuerySnapshot>(
          future: firestoreService.gettodaydealsProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            var allProducts = snapshot.data!.docs;

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 300,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to product details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemDetails(
                                title: "${allProducts[index]['p_name']}",
                                data: allProducts[index],
                              )),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.memory(
                            base64Decode(allProducts[index]['p_image']),
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.fill),
                        const Spacer(),
                        Text("${allProducts[index]['p_name']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        const SizedBox(height: 5),
                        Text("${allProducts[index]['p_price']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
