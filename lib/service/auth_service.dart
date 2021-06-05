import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/main_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthService {
  ///for auth  Register
  Future<void> setPhotoUserTOStorage(
      PickedFile photoFile, String userPhotoId, BuildContext context) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userPhotoId);
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(photoFile.path));
      String url = await uploadTask.then((url) {
        return ref.getDownloadURL();
      });
      await setUserInfoTOFirestore(url, context, photoFile);
    } catch (exStorage) {
      print("errorUploadStorage:::" + exStorage.toString());
    }
  }

  Future<void> setUserInfoTOFirestore(
      String url, BuildContext context, PickedFile photoFile) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: emailTextEditingController.text.trim(),
              password: passWordTextEditingController.text.trim());
      if (userCredential != null) {
        await usersSet.doc(userCredential.user.uid).set({
          "id": userCredential.user.uid,
          "picture": url,
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
        });
      }

      await getCurrentUser(context);
      await clearList1(context, photoFile);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        show('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        show('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  clearList1(BuildContext context, PickedFile photoFile) {
    photoFile = null;
    nameTextEditingController.clear();
    emailTextEditingController.clear();
    passWordTextEditingController.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  ///for auth login
  Future<void> signIn(BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passWordTextEditingController.text.trim(),
      );
      await getCurrentUser(context);
      await clearList(context);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        show("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        show("Wrong password provided for that user.");
      }
    }
  }

  Future<void> clearList(BuildContext context) async {
    passWordTextEditingController.clear();
    emailTextEditingController.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  ///google signIn
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
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
      await auth.signInWithCredential(credential);
      await getCurrentUser(context);
      pushToHomePage(context);
    } on FirebaseAuthException catch (e) {
      if (e.credential.signInMethod == null) {
        show("some Thing went wrong");
      } else if (e.email == null) {
        show("check you network");
      }else{
        show("check you network");
      }
    }
    return null;
  }

  /// faceBook
  Future<UserCredential> signInWithFacebook(BuildContext context) async {
    try {
      final AccessToken result = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      await usersSet.doc(result.userId).set(userData).whenComplete(
          () => usersSet.doc(result.userId).update({"token": result.token}));
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.token);
      await auth.signInWithCredential(facebookAuthCredential);
      await getCurrentUser(context);
      pushToHomePage(context);
    } catch (ex) {
      print(ex.toString());
      show("Some thing went wrong");
      show("check you network");
    }
    return null;
  }

  ///this for get current user
  static Future<User> getCurrentUser(BuildContext context) async {
    currentUser = auth.currentUser;
    return currentUser;
  }

  /// Flutter toast
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

  void pushToHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
