import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/main_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/service/locale_notficition.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class SetCarTOFireStore extends ChangeNotifier {
  String carId = uuid.v1();
  LocaleNotifications notifications =LocaleNotifications();
  // this method for upload image to Storage
  Future<void> upLoadToStorage(BuildContext context,PickedFile file,
      bool installment, String dropdownValue) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('car')
          .child(carId);
      firebase_storage.UploadTask uploadTask = ref.putFile(File(file.path));
      String url = await uploadTask.then((url) {
        return ref.getDownloadURL();
      });
      print("don in storage now to firestore::::" + uploadTask.toString());
      await downloadUrl(url, dropdownValue, installment,context);
    } catch (exStorage) {
      print("errorUploadStorage:::" + exStorage.toString());
    }
    notifyListeners();
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
    notifyListeners();
  }

  Future<void> downloadUrl(
      String url, String dropdownValue, bool installment, BuildContext context) async {
    print(url);
    return await uploadToFirestore(url, dropdownValue, installment,context);
  }

// this method for upload to fire store
  Future<void> uploadToFirestore(
      String url, String dropdownValue, bool installment, BuildContext context ) async {
    try {
      await saleCarReference.add({
        "postId": currentUser.uid.toString(),
        "image": url,
        "brand": brandTextEditingController.text,
        "model": modelTextEditingController.text,
        "city": cityTextEditingController.text,
        "color": colorTextEditingController.text,
        "price": priceTextEditingController.text,
        "km": kmTextEditingController.text,
        "phone": phoneTextEditingController.text,
        "gaz": gazTextEditingController.text,
        "gear": gearTextEditingController.text,
        "not": notTextEditingController.text,
        "statusCar": dropdownValue.toString(),
        "installment": installment ? "Available" : "Not available",
      });
      print("don upload data to cloud");
      clearList(context);
      notifications.publishDon();
    } catch (ex) {
      show("some thing went wrong");
      print("errorUploadToFirestore::" + ex.toString());
    }
  }

  clearList(context) {
    brandTextEditingController.clear();
    modelTextEditingController.clear();
    cityTextEditingController.clear();
    gearTextEditingController.clear();
    colorTextEditingController.clear();
    gazTextEditingController.clear();
    kmTextEditingController.clear();
    priceTextEditingController.clear();
    notTextEditingController.clear();
    phoneTextEditingController.clear();
    print("clear and pop");
  }

  notifyListeners();
}
