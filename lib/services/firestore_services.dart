import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/consts.dart';

class firestoreService {
  //get user details

  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProduct(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartsCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteCartDocument(docId) {
    return firestore.collection(cartsCollection).doc(docId).delete();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlist() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getCount() async {
    var res = await Future.wait([
      firestore
          .collection(cartsCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static Stream<QuerySnapshot> getAllProducts() {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('isFeatured', isEqualTo: true)
        .get();
  }

  static searchProducts(title) {
    return firestore
        .collection(productsCollection)
        .get();
  }
}
