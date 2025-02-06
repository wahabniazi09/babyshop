import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/consts.dart';
import 'package:drawer/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AdminproductServices {
  // Controllers for input fields
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  // Categories and subcategories
  List<String> categorylist = [];
  List<String> subCategorylist = [];
  List<Category> category = [];
  List<String> pimageslinks = [];

  List<dynamic?> pimagelist = List.filled(3, null, growable: false);

  String categoryvalue = '';
  String subcategoryvalue = '';

  Future<void> getcategory() async {
    try {
      String data =
          await rootBundle.loadString("lib/services/category_model.json");
      var cat = categoryModelFromJson(data);
      category = cat.categories;
      populateCategoryList();
    } catch (e) {
      debugPrint("Error loading categories: $e");
    }
  }

  void populateCategoryList() {
    categorylist.clear();
    for (var item in category) {
      categorylist.add(item.name);
    }
  }

  void populateSubCategoryList(String cat) {
    subCategorylist.clear();

    var data = category.where((element) => element.name == cat).toList();
    if (data.isNotEmpty) {
      subCategorylist.addAll(data.first.subcategory);
    } else {
      debugPrint("No subcategories found for: $cat");
    }
  }

  addFeatured(docID) async {
    await firestore.collection(productsCollection).doc(docID).set(
        {'featured_id': currentUser!.uid, 'isFeatured': true},
        SetOptions(merge: true));
  }

  removeFeatured(docID) async {
    await firestore
        .collection(productsCollection)
        .doc(docID)
        .set({'featured_id': '', 'isFeatured': false}, SetOptions(merge: true));
  }

  removeProduct(docID) async {
    await firestore.collection(productsCollection).doc(docID).delete();
  }

   removeOrders(docID) async {
    await firestore.collection(ordersCollection).doc(docID).delete();
  }

  addtopCategory(docID) async {
    await firestore.collection(productsCollection).doc(docID).set(
        {'TopCategory': true},
        SetOptions(merge: true));
  }

  removetopCategory(docID) async {
    await firestore
        .collection(productsCollection)
        .doc(docID)
        .set({'TopCategory': false}, SetOptions(merge: true));
  }

  addtodaydeals(docID) async {
    await firestore.collection(productsCollection).doc(docID).set(
        {'TodayDeals': true},
        SetOptions(merge: true));
  }

  removetodaydeals(docID) async {
    await firestore
        .collection(productsCollection)
        .doc(docID)
        .set({'TodayDeals': false}, SetOptions(merge: true));
  }

  addflashsale(docID) async {
    await firestore.collection(productsCollection).doc(docID).set(
        {'FlashSale': true},
        SetOptions(merge: true));
  }

  removeflashsale(docID) async {
    await firestore
        .collection(productsCollection)
        .doc(docID)
        .set({'FlashSale': false}, SetOptions(merge: true));
  }
}
