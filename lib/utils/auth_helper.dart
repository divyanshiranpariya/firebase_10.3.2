import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();

  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>> signInAsGuestUser() async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      res['user'] == user;
    } on FirebaseAuthException catch (e) {
      switch (e) {
        case "Network-request-failed":
          res['error'] = "No Internet avaqilable";
          break;
        case "Operation-not-allowed":
          res['error'] = "No Internet avaqilable";
          break;
        case "Weak-Password":
          res['error'] = "password must be greater than 6 letters..";
          break;
        case "email-already-in-use":
          res['error'] = "This email is already  exixts...";
          break;
        default:
          res['error'] = "${e.code}";
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      res['user'] == user;
    } on FirebaseAuthException catch (e) {
      switch (e) {
        case "Network-request-failed":
          res['error'] = "No Internet avaqilable";
          break;
        case "Operation-not-allowed":
          res['error'] = "No Internet avaqilable";
          break;
        default:
          res['error'] = "${e.code}";
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      res['user'] == user;
    } on FirebaseAuthException catch (e) {
      switch (e) {
        case "Network-request-failed":
          res['error'] = "No Internet avaqilable";
          break;
        case "Operation-not-allowed":
          res['error'] = "No Internet avaqilable";
          break;
        default:
          res['error'] = "${e.code}";
      }
    }
    return res;
  }

  googleInSign() async {
    Map<String, dynamic> res = {};
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      res['user'] = user;

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      res['error'] = "${e}";
    }
    return res;
  }

  Future<void> signOutUser() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
