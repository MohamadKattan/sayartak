import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
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

class AdminAddCAR extends StatefulWidget {
  @override
  _AdminAddCARState createState() => _AdminAddCARState();
}

class _AdminAddCARState extends State<AdminAddCAR> {
  final ImagePicker _picker = ImagePicker();
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  PickedFile _imageFile;
  PickedFile _videoFile;
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
        title: Text("Add a car"),
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
                      labelText: "Brand",
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
                      labelText: "Model",
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
                      labelText: "city",
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
                      labelText: "gear",
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
                      labelText: "Color",
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
                      labelText: "gaz or else",
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
                      labelText: "K.m?",
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
                      labelText: "Price ? ",
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
                      labelText: "Phone ",
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
                      labelText: "Nots",
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
                      Text("installment"),
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
                        print("Add a car");
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          height: 80.0,
                          child: Center(
                              child: Text("Add a car",
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
      print("Error getImage is:::" + ex.toString());
    }
  }

// for show dialog when click video or image picker
  void _shoowdialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Media picker",
            text1: "Pick an Image",
            text2: "Pick a video",
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
        show("image can\'t be empty");
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
      }  else if (dropdownValue == "select") {
        show("Choice number of gallery!!");
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
  Future<void> uploadToFirestore(
    String url,
  ) async {
    try {
      adminAddCarReference.add({
        "image": url,
        "video": null,
        "brand": brandTextEditingController.text,
        "model": modelTextEditingController.text,
        "city": cityTextEditingController.text,
        "color": colorTextEditingController.text,
        "price": priceTextEditingController.text,
        "km": kmTextEditingController.text,
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
    dropdownValue = 'select';
    installment = false;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AdminPanel();
    }));
    print("clear and pop");
  }
}
