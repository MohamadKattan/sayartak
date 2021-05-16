import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/main_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:sayartak/widget/custom_dialog.dart';
import 'package:sayartak/widget/custom_drop_button.dart';
import 'package:sayartak/widget/custom_text_failed.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var uuid = Uuid();

class AddScreen extends StatefulWidget {
  AddScreen({Key key}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final ImagePicker _picker = ImagePicker();
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  PickedFile _imageFile;
  PickedFile _videoFile;
  dynamic _pickImageError;
  String carId = uuid.v1();
  bool isVideo = false;
  bool installment = false;
  bool isLoading = false;
  String dropdownValue = 'select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text(AppLocalizations.of(context).image),
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
        title: Text(AppLocalizations.of(context).addcar),
        centerTitle: false,
        backgroundColor: Colors.black,
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
                _videoFile != null
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              child: Icon(
                                Icons.play_arrow,
                                size: 35.0,
                                color: Colors.black,
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
                      labelText: AppLocalizations.of(context).brand,
                      minLines: 1,
                      maxLines: 2,
                      controller: brandTextEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: AppLocalizations.of(context).model,
                      minLines: 1,
                      maxLines: 2,
                      controller: modelTextEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: AppLocalizations.of(context).city,
                      minLines: 1,
                      maxLines: 2,
                      controller: cityTextEditingController,
                      textInputType: TextInputType.streetAddress,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: AppLocalizations.of(context).gear,
                      minLines: 1,
                      maxLines: 2,
                      controller: gearTextEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: AppLocalizations.of(context).color,
                      minLines: 1,
                      maxLines: 2,
                      controller: colorTextEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: AppLocalizations.of(context).gaz,
                      minLines: 1,
                      maxLines: 2,
                      controller: gazTextEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: AppLocalizations.of(context).km,
                      minLines: 1,
                      maxLines: 2,
                      controller: kmTextEditingController,
                      textInputType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText: AppLocalizations.of(context).price,
                      minLines: 1,
                      maxLines: 2,
                      controller: priceTextEditingController,
                      textInputType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: customTextField(
                      labelText:AppLocalizations.of(context).phone,
                      minLines: 1,
                      maxLines: 2,
                      controller: phoneTextEditingController,
                      textInputType: TextInputType.phone,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: customTextField(
                      labelText:AppLocalizations.of(context).not,
                      minLines: 1,
                      maxLines: 2,
                      controller: notTextEditingController,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          value: installment,
                          onChanged: _manyTime),
                      Text(AppLocalizations.of(context).installment),
                      SizedBox(
                        width: 100.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          width: MediaQuery.of(context).size.height * 14 / 100,
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
                                'newCar',
                                'usedCar',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        checkIfFieldNotEmpty();
                        print("sale a car");
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          height: 80.0,
                          child: Center(
                              child: Text(AppLocalizations.of(context).salecar,
                                  style: TextStyle(color: Colors.white))))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

// this method for check box
  void _manyTime(bool manyTimeOk) {
    setState(() {
      installment = true;
    });
  }

  // this method for pickImage+video
  void pickImageAndVideo(ImageSource source, {BuildContext context}) async {
    try {
      if (isVideo) {
        final pPickedFile = await _picker.getVideo(
            source: source, maxDuration: const Duration(seconds: 10));
        setState(() {
          _videoFile = pPickedFile;
        });
      } else {
        final pickedFile = await _picker.getImage(
          source: source,
          maxWidth: 200.0,
          maxHeight: 350.0,
          imageQuality: 80,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (ex) {
      setState(() {
        _pickImageError = ex;
      });
      print("Error getImage is:::" + ex.toString());
    }
  }

// for show dialog when click video or image picker
  void _shoowdialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title:AppLocalizations.of(context).mediapicker,
            text1: AppLocalizations.of(context).pickimage,
            text2: AppLocalizations.of(context).pickvideo,
            onTap: () {
              pickImageAndVideo(ImageSource.gallery, context: context);
              Navigator.pop(context);
            },
            onTap1: () {
              isVideo = true;
              pickImageAndVideo(ImageSource.camera, context: context);
              Navigator.pop(context);
            },
          );
        });
  }

// this method for check if verbill is not null
  void checkIfFieldNotEmpty() {
    try {
      if (_imageFile == null) {
        show(AppLocalizations.of(context).showimage);
        // }else if(_videoFile==null){
        //   show("Video can\'t be empty");
        // } else if(brandTextEditingController.text.isEmpty){
        show("brand car can\'t be empty");
      } else if (modelTextEditingController.text.isEmpty) {
        show("Model car can\'t be empty");
      } else if (cityTextEditingController.text.isEmpty) {
        show("City car can\'t be empty");
      } else if (gearTextEditingController.text.isEmpty) {
        show("gear car can\'t be empty");
      } else if (colorTextEditingController.text.isEmpty) {
        show("Color car can\'t be empty");
      } else if (gazTextEditingController.text.isEmpty) {
        show("gaz field car can\'t be empty");
      } else if (kmTextEditingController.text.isEmpty) {
        show("km field car can\'t be empty");
      } else if (priceTextEditingController.text.isEmpty) {
        show("price field car can\'t be empty");
      } else if (phoneTextEditingController.text.isEmpty) {
        show("Phone field car can\'t be empty");
      } else if (dropdownValue == "select") {
        show("Choice if car new or Used!!");
      } else {
        print("to Storage");
        upLoadToStorage();
      }
    } catch (ex) {
      show("Some thing went wrong");
    }
  }

// this method for show flutter toast
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

// this method for upload image to Storage
  Future<void> upLoadToStorage() async {
    try {
      setState(() {
        isLoading = true;
      });
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('car')
          .child(carId);
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
      saleCarReference.add({
        "postId": currentUser.uid.toString(),
        "image": url,
        "video": null,
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
    _videoFile = null;
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
    dropdownValue = 'select';
    installment = false;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
    print("clear and pop");
  }
}
