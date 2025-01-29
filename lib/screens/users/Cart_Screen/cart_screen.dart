import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/colors.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/users/Cart_Screen/shiping_screen.dart';
import 'package:drawer/services/cart_services.dart';
import 'package:drawer/services/firestore_services.dart';
import 'package:drawer/screens/users/user_widget/beveled_button.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
   CartScreen({super.key});

  var cartservices = CartServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: firestoreService.getCart(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Cart is empty'),
            );
          } else {
            var data = snapshot.data!.docs;
            cartservices.calculate(data);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Subtle shadow
                                blurRadius: 4,
                                offset: const Offset(0, 2), // Shadow offset
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading:
                                Image.memory(base64Decode(data[index]['img'])),
                            title: Text(
                              "${data[index]['title']} x[${data[index]['qty']}]",
                              style: const TextStyle(
                                fontFamily: semibold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "${data[index]['tprice']}",
                              style: const TextStyle(fontFamily: semibold),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                firestoreService
                                    .deleteCartDocument(data[index].id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: redColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                            fontFamily: semibold,
                            color: darkFontGrey,
                          ),
                        ),
                        Text(
                          cartservices.totalp.value.toString(),
                          style: const TextStyle(
                            fontFamily: semibold,
                            color: redColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 40,
                    child: BeveledButton(
                      title: 'Process To Shipping',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ShippingScreen()));
                      },
                      width: MediaQuery.of(context).size.width - 60,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
