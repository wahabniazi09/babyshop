import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drawer/consts/colors.dart';
import 'package:drawer/services/adminproduct_services.dart';
import 'package:drawer/screens/admin/admin_product_screen/component/product_dropdown.dart';
import 'package:drawer/screens/admin/admin_product_screen/component/product_image.dart';
import 'package:drawer/screens/admin/admin_widget/admin_custom_form.dart';

class UpdateProduct extends StatefulWidget {
  final String productId;
  final dynamic productData;

  const UpdateProduct({super.key, required this.productId, required this.productData});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final AdminproductServices controller = AdminproductServices();
  bool isLoading = false;
  Uint8List? profileImageWeb;
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    controller.getcategory().then((_) {
      setState(() {}); // Ensure category list updates after fetching
    });
    _initializeFields();
  }

  void _initializeFields() {
    controller.pnameController.text = widget.productData['p_name'];
    controller.pdescController.text = widget.productData['p_desc'];
    controller.ppriceController.text = widget.productData['p_price'].toString();
    controller.pquantityController.text = widget.productData['p_quantity'].toString();
    controller.categoryvalue = widget.productData['p_category'];
    controller.subcategoryvalue = widget.productData['p_sub_category'];
  }

  Future<void> addData(BuildContext context) async {
    try {
      if ((kIsWeb && profileImageWeb == null) ||
          (!kIsWeb && profileImagePath == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Please select an image',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
        return;
      }
      setState(() {
        isLoading = true;
      });

      String base64image;
      if (kIsWeb) {
        base64image = base64Encode(profileImageWeb!);
      } else {
        base64image = base64Encode(File(profileImagePath!).readAsBytesSync());
      }

      final updatedData = {
        'isFeatured': false,
        'p_category': controller.categoryvalue,
        'p_sub_category': controller.subcategoryvalue,
        'p_wishlist': FieldValue.arrayUnion([]),
        'p_desc': controller.pdescController.text,
        'p_name': controller.pnameController.text,
        'p_price': controller.ppriceController.text,
        'p_quantity': controller.pquantityController.text,
        'featured_id': '',
        'p_image': base64image,
      };

      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Update Product',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Details updated successfully!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Failed to update details: $e',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> changeImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return;

      if (kIsWeb) {
        profileImageWeb = await pickedFile.readAsBytes();
      } else {
        profileImagePath = pickedFile.path;
      }
      setState(() {});
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: whiteColor),
        title: const Text(
          'Update Product',
          style: TextStyle(fontSize: 16.0, color: whiteColor),
        ),
        actions: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : OutlinedButton(
                  onPressed: () => addData(context),
                  child: const Text('Update Product', style: TextStyle(color: whiteColor)),
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
                controller: controller.pnameController,
              ),
              const SizedBox(height: 10),
              AdminCustomTextField(
                label: 'Product Description',
                hint: 'Enter Product Description',
                ispass: false,
                controller: controller.pdescController,
              ),
              const SizedBox(height: 10),
              AdminCustomTextField(
                label: 'Product Price',
                hint: 'Enter Product Price',
                ispass: false,
                controller: controller.ppriceController,
              ),
              const SizedBox(height: 10),
              AdminCustomTextField(
                label: 'Product Quantity',
                hint: 'Enter Product Quantity',
                ispass: false,
                controller: controller.pquantityController,
              ),
              const SizedBox(height: 10),
              productDropdown(
                "Category",
                controller.categorylist, // Ensure this is a List<String>
                controller.categoryvalue,
                (value) {
                  setState(() {
                    controller.categoryvalue = value;
                    controller.populateSubCategoryList(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              productDropdown(
                "Sub Category",
                controller.subCategorylist, // Ensure this is a List<String>
                controller.subcategoryvalue,
                (value) {
                  setState(() {
                    controller.subcategoryvalue = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Update Product Images',
                style: TextStyle(color: whiteColor, fontFamily: 'bold'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  if (profileImageWeb != null) {
                  Image.memory(profileImageWeb!, width: 80, height: 80, fit: BoxFit.cover);
                  } else if (profileImagePath != null) {
                    Image.file(File(profileImagePath!), width: 80, height: 80, fit: BoxFit.cover);
                  } else {
                    Image.memory(
                        base64Decode(widget.productData['p_image']),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover);
                  }

                  return GestureDetector(
                    onTap: () => changeImage(),
                    child: productImage(label: "${index + 1}"),
                  );
                }),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
