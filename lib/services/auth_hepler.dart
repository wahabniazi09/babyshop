import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drawer/consts/consts.dart';
import 'package:flutter/foundation.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signIn({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
    return userCredential;
  }

  Future<UserCredential?> signUp({
    email,
    password,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
    return userCredential;
  }

  Future signout() async {
    await auth.signOut();
  }

 storeUserData({
  required String name,
  required String email,
  required String password,
  required String phone,
  required String address,
  required String role,
}) async {

      DocumentReference store = firestore.collection(userCollection).doc(currentUser!.uid);

      await store.set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
        'role': role,
        'id': currentUser!.uid,
        'imageurl': '',
        'cart_count': "00",
        'wishlist_count': "00",
        'order_count': "00",
      });   
}

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {
      error.toString();
    });
  }
}
