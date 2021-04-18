import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sayartak/confige.dart';

class FaceBookSingIn {
  Future<UserCredential> signInWithFacebook() async {
    try {
      final AccessToken result = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      await usersSet.doc(result.userId).set(userData).whenComplete(
          () => usersSet.doc(result.userId).update({"token": result.token}));
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.token);
      return await auth.signInWithCredential(facebookAuthCredential);
    } catch (ex) {
      print(ex.toString());
      show("Some thing went wrong");
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
