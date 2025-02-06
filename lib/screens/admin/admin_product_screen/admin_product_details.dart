import 'dart:convert';

import 'package:drawer/consts/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:drawer/consts/colors.dart';

class AdminProductDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const AdminProductDetails({required this.title, this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: Text(
          title ?? 'Item Details',
          style: const TextStyle(
            fontFamily: bold,
            color: darkFontGrey,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Swiper for Images
                    if (data != null && data['p_image'] != null)
                      SizedBox(
                        height: 350,
                        child: Swiper(
                          itemCount: data['p_image'].length,
                          autoplay: false,
                          itemBuilder: (context, index) {
                            return Image.memory(
                              base64Decode(data['p_image']),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )
                    else
                      const Center(child: Text('No images available.')),

                    const SizedBox(height: 20),

                    Text(
                      data['p_name'] ?? 'name.',
                      style: const TextStyle(
                        fontFamily: semibold,
                        fontSize: 16,
                        color: darkFontGrey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          data['p_category'] ?? 'category.',
                          style: const TextStyle(
                            fontFamily: semibold,
                            fontSize: 16,
                            color: darkFontGrey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          // data['p_sub_category'] ??
                          "${data['p_sub_category']}",
                          style: const TextStyle(
                            fontFamily: semibold,
                            fontSize: 16,
                            color: darkFontGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Item Price
                    Text(
                      data['p_price'] != null
                          ? 'Rs: ${data['p_price']}'
                          : 'Price Not Available',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: bold,
                        color: redColor,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Quantity",
                              style: TextStyle(color: textfieldGrey),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${data['p_quantity']} available',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: darkFontGrey,
                                    fontFamily: bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Description Section
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: darkFontGrey,
                        fontFamily: semibold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data['p_desc'] ?? 'This is a dummy description....',
                      style: const TextStyle(
                        color: darkFontGrey,
                        fontFamily: semibold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Video List
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
