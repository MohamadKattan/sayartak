import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sayartak/confige.dart';

class GoogleAuthSingIn {
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await usersSet.doc(googleUser.id).set({
        "id": googleUser.id,
        "name": googleUser.displayName,
        "email": googleUser.email,
        "picture": googleUser.photoUrl,
        "token": credential.idToken,
      });
      return await auth.signInWithCredential(credential);
    } catch (ex) {
      show("Some Thing went Wrong");
      print("googleAuthError" + ex.toString());
    }
    return null;
  }

  Future<void> show(String msg) async {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
