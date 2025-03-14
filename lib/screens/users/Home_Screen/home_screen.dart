import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BabyShop/screens/users/Category_Screen.dart/components/item_details.dart';
import 'package:BabyShop/screens/users/Home_Screen/component/all_product.dart';
import 'package:BabyShop/screens/users/Home_Screen/component/feature_button.dart';
import 'package:BabyShop/screens/users/Home_Screen/component/seach_screen.dart';
import 'package:BabyShop/screens/users/Home_Screen/flash_sale.dart';
import 'package:BabyShop/screens/users/Home_Screen/today_deals.dart';
import 'package:BabyShop/services/firestore_services.dart';
import 'package:BabyShop/screens/users/user_widget/home_button.dart';
import 'package:BabyShop/screens/users/user_widget/lish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:BabyShop/consts/consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(12),
        color: lightGrey,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (searchController.text.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                          title: searchController.text,
                                        )));
                          }
                        },
                        icon: const Icon(Icons.search)),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: 'Search anything...',
                    hintStyle: const TextStyle(color: textfieldGrey)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 200,
              child: Swiper(
                itemCount: brandlist.length,
                autoplay: true,
                itemBuilder: (context, index) {
                  return Container(
                    child: Image.asset(
                      brandlist[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10), // Adds spacing between buttons
                  child: homeButton(
                    width: 150,
                    height: 140,
                    iconPath: index == 0
                        ? icTodaysDeal
                        : icFlashDeal, // Example icons
                    title: index == 0 ? 'Today Deal' : 'Flash Sale',
                    onTap: () {
                      index == 0
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TodayDeals()))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FlashSale()));
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Featured Category',
                style: TextStyle(
                    color: darkFontGrey, fontSize: 18, fontFamily: semibold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    categoriesList123.length,
                    (index) => Column(
                          children: [
                            featureButton(
                              context: context,
                              icon: categorylisticon12[index],
                              title: categoriesList12[index],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            featureButton(
                              context: context,
                              icon: categorylisticon123[index],
                              title: categoriesList123[index],
                            )
                          ],
                        )).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: redColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Feature Products',
                    style: TextStyle(
                      color: whiteColor,
                      fontFamily: bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder(
                          future: firestoreService.getFeaturedProducts(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No Wishlist yet!',
                                  style: TextStyle(
                                    color: darkFontGrey,
                                    fontFamily: semibold,
                                  ),
                                ),
                              );
                            } else {
                              var featuredata = snapshot.data!.docs;
                              return Row(
                                children: List.generate(
                                  featuredata.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ItemDetails(
                                                      title:
                                                          "${featuredata[index]['p_name']}",
                                                      data: featuredata[index],
                                                    )));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.memory(
                                            base64Decode(
                                                featuredata[index]['p_image']),
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "${featuredata[index]['p_name']}",
                                            style: const TextStyle(
                                              fontFamily: semibold,
                                              color: darkFontGrey,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Rs: ${featuredata[index]['p_price']}",
                                            style: const TextStyle(
                                              fontFamily: bold,
                                              color: redColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          })),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Container(
            //   height: 200,
            //   child: Swiper(
            //     itemCount: brandlist2.length,
            //     autoplay: true,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         child: Image.asset(
            //           brandlist2[index],
            //           fit: BoxFit.cover,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
           Container(
  padding: const EdgeInsets.all(12),
  width: double.infinity,
  decoration: const BoxDecoration(color: Colors.white),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'All Products',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 10),
      StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          var allProducts = snapshot.data!.docs;
          var displayedProducts = allProducts.take(8).toList(); // Show only 8 products

          return Column(
            children: [
              GridView.builder(
                padding: const EdgeInsets.all(8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: displayedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetails(
                            title: "${displayedProducts[index]['p_name']}",
                            data: displayedProducts[index],
                          ),
                        ),
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
                            base64Decode(displayedProducts[index]['p_image']),
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          const Spacer(),
                          Text(
                            "${displayedProducts[index]['p_name']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, color: Colors.black87),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Rs: ${displayedProducts[index]['p_price']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (allProducts.length > 8) // Show the button only if more than 8 products exist
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllProductsPage(
                            productStream: firestoreService.getAllProducts(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.orange[900],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      "View All",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    ],
  ),
),
          ],
        )),
      ),
    );
  }
}
