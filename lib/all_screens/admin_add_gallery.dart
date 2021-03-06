import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/admin_panel.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:sayartak/widget/custom_dialog.dart';
import 'package:sayartak/widget/custom_text_failed.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class AddGalleryScreen extends StatefulWidget {
  @override
  _AddGalleryScreenState createState() => _AddGalleryScreenState();
}

class _AddGalleryScreenState extends State<AddGalleryScreen> {
  final ImagePicker _picker = ImagePicker();
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  PickedFile _imageFile;
  String galleryId = uuid.v1();
  bool isVideo = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text("Image"),
              IconButton(
                  tooltip: "image",
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    _shoowdialog();
                    print("addImage");
                  }),
            ],
          )
        ],
        backgroundColor: Colors.black,
        title: Text("Admin add gallery"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            isLoading ? CustomCircular() : Text(""),
            ListView(
              children: [
                SizedBox(
                  height: 15.0,
                ),
                _imageFile != null
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.file(
                                File(_imageFile.path),
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                        ))
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: "gallery name",
                      minLines: 1,
                      maxLines: 2,
                      controller: nameGalleryEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: "Main Address",
                      minLines: 1,
                      maxLines: 2,
                      controller: address1GalleryEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: "Secondary address",
                      minLines: 1,
                      maxLines: 2,
                      controller: address2GalleryEditingController,
                      textInputType: TextInputType.streetAddress,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: "Location",
                      minLines: 1,
                      maxLines: 2,
                      controller: locationGalleryEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: "Phone ",
                      minLines: 1,
                      maxLines: 2,
                      controller: phoneTextEditingController,
                      textInputType: TextInputType.phone,
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        checkIfFieldNotEmpty();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          height: 80.0,
                          child: Center(
                              child: Text("Add new gallery",
                                  style: TextStyle(color: Colors.white))))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // for show dialog when click video or image picker
  void _shoowdialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Media picker",
            text1: "Pick an Image",
            text2: "",
            onTap: () {
              pickImageAndVideo(ImageSource.gallery, context: context);
              Navigator.pop(context);
            },
          );
        });
  }

  // this method for pickImage+video
  void pickImageAndVideo(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 150.0,
        maxHeight: 250.0,
        imageQuality: 80,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (ex) {
      print("Error getImage is:::" + ex.toString());
    }
  }

  // this method for show flutter toast
  void show(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // this method for check if verbill is not null
  void checkIfFieldNotEmpty() {
    try {
      if (_imageFile == null) {
        show("image can\'t be empty");
      } else if (nameGalleryEditingController.text.isEmpty) {
        show("Name car can\'t be empty");
      } else if (address1GalleryEditingController.text.isEmpty) {
        show("Main address  can\'t be empty");
      } else if (address2GalleryEditingController.text.isEmpty) {
        show("Secondary address can\'t be empty");
      } else if (phoneTextEditingController.text.isEmpty) {
        show("Phone field car can\'t be empty");
      } else {
        print("to Storage");
        upLoadToStorage();
      }
    } catch (ex) {
      show("Some thing went wrong");
    }
  }

  // this method for upload image to Storage
  Future<void> upLoadToStorage() async {
    try {
      setState(() {
        isLoading = true;
      });
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('galleries')
          .child(galleryId);
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(_imageFile.path));
      String url = await uploadTask.then((url) {
        return ref.getDownloadURL();
      });
      print("don in storage now to firestore::::" + uploadTask.toString());
      await downloadUrl(url);
    } catch (exStorage) {
      print("errorUploadStorage:::" + exStorage.toString());
    }
  }

  Future<void> downloadUrl(String url) async {
    print(url);
    return await uploadToFirestore(url);
  }

  // this method for upload to fire store
  Future<void> uploadToFirestore(String url) async {
    try {
      newGalleryReference.add({
        "image": url,
        "name": nameGalleryEditingController.text,
        "address1": address1GalleryEditingController.text,
        "address2": address2GalleryEditingController.text,
        "location": locationGalleryEditingController.text,
        "phone": phoneTextEditingController.text,
      });
      print("don upload data to cloud");
      setState(() {
        isLoading = false;
      });
      await clearList();
    } catch (ex) {
      show("some thing went wrong");
      print("errorUploadToFirestore::" + ex.toString());
    }
  }

  clearList() {
    _imageFile = null;
    nameGalleryEditingController.clear();
    address1GalleryEditingController.clear();
    address2GalleryEditingController.clear();
    locationGalleryEditingController.clear();
    phoneTextEditingController.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AdminPanel();
    }));
    print("clear and pop");
  }
}
