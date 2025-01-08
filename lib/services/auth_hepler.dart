import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signIn({
    required String email, 
    required String password
    }) async {
    try {
      UserCredential userCredential =await auth.signInWithEmailAndPassword(
        email: email, 
        password: password
        );
      
      DocumentSnapshot userDoc = await firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
      return userDoc['role'];
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
          );

      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "name": name,
        "email": email,
        "role": role,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    await auth.signOut();
  }
}
