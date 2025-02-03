import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/screens/admin/admin_product_screen/admin_products_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drawer/services/adminproduct_services.dart';
import 'package:drawer/consts/colors.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/admin/admin_product_screen/component/product_dropdown.dart';
import 'package:drawer/screens/admin/admin_product_screen/component/product_image.dart';
import 'package:drawer/screens/admin/admin_widget/admin_custom_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:convert'; // Import for Base64 encoding

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var controller = AdminproductServices();
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    controller.getcategory().then((_) {
      setState(() {}); // Ensure category list updates after fetching
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: whiteColor),
        title: const Text(
          'Add Products',
          style: TextStyle(fontSize: 16.0, color: whiteColor),
        ),
        actions: [
         isloading ? const Center(
          child: CircularProgressIndicator(),
         ) :OutlinedButton(
            onPressed: () => addData(context),
            child: const Text(
              'Add Product',
              style: TextStyle(color: whiteColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminCustomTextField(
                  label: 'Product Name',
                  hint: 'Enter Product Name',
                  ispass: false,
                  controller: controller.pnameController),
              const SizedBox(height: 10),
              AdminCustomTextField(
                  label: 'Product Description',
                  hint: 'Enter Product Description',
                  ispass: false,
                  controller: controller.pdescController),
              const SizedBox(height: 10),
              AdminCustomTextField(
                  label: 'Product Price',
                  hint: 'Enter Product Price',
                  ispass: false,
                  controller: controller.ppriceController),
              const SizedBox(height: 10),
              AdminCustomTextField(
                  label: 'Product Quantity',
                  hint: 'Enter Product Quantity',
                  ispass: false,
                  controller: controller.pquantityController),
              const SizedBox(height: 10),
              // Category Dropdown
              productDropdown(
                "Category",
                controller.categorylist,
                controller.categoryvalue,
                (value) {
                  setState(() {
                    controller.categoryvalue = value;
                    controller.subcategoryvalue = ''; // Reset subcategory
                    controller.populateSubCategoryList(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              // Sub Category Dropdown
              productDropdown(
                "Sub Category",
                controller.subCategorylist,
                controller.subcategoryvalue,
                (value) {
                  setState(() {
                    controller.subcategoryvalue = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Choose Product Image',
                style: TextStyle(color: whiteColor, fontFamily: bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (index) => controller.pimagelist[index] != null
                      ? (kIsWeb
                          ? Image.memory(
                              controller.pimagelist[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ) // Display image for web
                          : Image.file(
                              controller.pimagelist[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )) // Display image for mobile
                      : GestureDetector(
                          onTap: () => pickImage(index),
                          child: productImage(
                            label: "${index + 1}",
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'First Image Will Be Your Display Image',
                style: TextStyle(color: fontGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(int index) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? img = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (img == null) return;

      if (kIsWeb) {
        // For web, use bytes
        Uint8List bytes = await img.readAsBytes();
        setState(() {
          controller.pimagelist[index] = bytes;
        });
      } else {
        // For mobile, use File
        setState(() {
          controller.pimagelist[index] = File(img.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Function to convert image to Base64 string
  Future<String> encodeImageToBase64(dynamic image) async {
    try {
      if (image is File) {
        // For mobile, read the file as bytes
        List<int> imageBytes = await image.readAsBytes();
        return base64Encode(imageBytes); // Encode bytes to Base64 string
      } else if (image is Uint8List) {
        // For web, directly encode the byte array
        return base64Encode(image);
      } else {
        throw Exception('Invalid image format');
      }
    } catch (e) {
      print("Error encoding image: $e");
      throw e;
    }
  }

  Future<void> addData(BuildContext context) async {
    try {
      if (controller.pimagelist.isEmpty || controller.pimagelist.every((image) => image == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Please select at least one image',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
        return;
      }

      setState(() {
        isloading = true;
      });

      // Convert images to Base64 strings
      List<String> base64Images = [];
      for (var image in controller.pimagelist) {
        if (image != null) {
          String base64String = await encodeImageToBase64(image); // Convert to Base64
          base64Images.add(base64String);
        }
      }

      // Store product data in Firestore
      var store = FirebaseFirestore.instance.collection('products').doc();
      await store.set({
        'isFeatured': false,
        'p_category': controller.categoryvalue,
        'p_sub_category': controller.subcategoryvalue,
        'p_image': FieldValue.arrayUnion(base64Images), 
        'p_wishlist': FieldValue.arrayUnion([]),
        'p_desc': controller.pdescController.text,
        'p_name': controller.pnameController.text,
        'p_price': controller.ppriceController.text,
        'p_quantity': controller.pquantityController.text,
        'featured_id': ''
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Product added successfully!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Failed to add product: $e',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    } finally {
      // Stop loading
      setState(() {
        isloading = false;
      });
    }
  }
}
