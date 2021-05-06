import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/admin_panel.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:sayartak/widget/custom_dialog.dart';
import 'package:sayartak/widget/custom_drop_button.dart';
import 'package:sayartak/widget/custom_text_failed.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class AdminEditGallery extends StatefulWidget {
  final String id;
  const AdminEditGallery({Key key, this.id}) : super(key: key);
  @override
  _AdminEditGalleryState createState() => _AdminEditGalleryState();
}

class _AdminEditGalleryState extends State<AdminEditGallery> {
  final ImagePicker _picker = ImagePicker();
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  PickedFile _imageFile;
  String galleryId = uuid.v1();
  bool isVideo = false;
  bool isLoading = false;
  String dropdownValue = 'select';
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
        title: Text("Edit Gallery Screen"),
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
                      labelText: "Name Of gallery",
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
                      labelText: "phone:",
                      minLines: 1,
                      maxLines: 2,
                      controller: phoneGalleryEditingController,
                      textInputType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: customDropButton(
                          value: dropdownValue,
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                          iconSize: 16,
                          elevation: 10,
                          onChanged: (String newValue) {
                            setState(() {
                              if (dropdownValue != null) {
                                return dropdownValue = newValue;
                              } else {
                                return null;
                              }
                            });
                            print("drop::" + dropdownValue);
                          },
                          items: <String>[
                            'select',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),
                ),
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
                              child: Text("Edit gallery",
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
      } else if (dropdownValue == "select") {
        show("Choice number of gallery!!");
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
      newGalleryReference.doc(widget.id).update({
        "postId": "admin",
        "image": url,
        "name": nameGalleryEditingController.text,
        "address1": address1GalleryEditingController.text,
        "address2": address2GalleryEditingController.text,
        "galleryNo": dropdownValue.toString(),
        "location": locationGalleryEditingController.text,
        "phone": phoneGalleryEditingController.text,
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
    dropdownValue="select";
    nameGalleryEditingController.clear();
    address1GalleryEditingController.clear();
    address2GalleryEditingController.clear();
    numberIdGalleryEditingController.clear();
    locationGalleryEditingController.clear();
    phoneGalleryEditingController.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AdminPanel();
    }));
    print("clear and pop");
  }
}
