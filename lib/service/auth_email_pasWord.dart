import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/all_screens/home_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sayartak/provider/current_user_provider.dart';

class LoginByEmailAuth{
  //for Register
  Future<void> setPhotoUserTOStorage(PickedFile photoFile,  String userPhotoId,BuildContext context) async {
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
      await setUserInfoTOFirestore(url,context,photoFile);
    } catch (exStorage) {
      print("errorUploadStorage:::" + exStorage.toString());
    }
  }
  Future<void> setUserInfoTOFirestore(String url,BuildContext context,PickedFile photoFile) async {
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
       await clearList1(context,photoFile);
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
  Future<User> getCurrentUser(BuildContext context) async {
    currentUser = auth.currentUser;
    await Provider.of<CurrentUserProvider>(context, listen: false)
        .getProviderCurrentUser(currentUser);
    return currentUser;
  }
  clearList1(BuildContext context,PickedFile photoFile) {
    photoFile = null;
    nameTextEditingController.clear();
    emailTextEditingController.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
  //for login****************************************
  Future<void> signIn(BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passWordTextEditingController.text.trim(),
      );
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