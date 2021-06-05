import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/login_screen.dart';
import 'package:sayartak/service/auth_service.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:sayartak/widget/custom_text_failed.dart';
import 'package:sayartak/confige.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var uuid = Uuid();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ImagePicker _picker = ImagePicker();
  PickedFile photoFile;
  String userPhotoId = uuid.v4();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  AuthService _authService = AuthService();
bool isloading1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(AppLocalizations.of(context).register),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            isloading1 ? CustomCircular() : Text(""),
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      addPhotoUser(ImageSource.gallery, context);
                    },
                    child: Container(
                        height: 70.0,
                        width: 140.0,
                        decoration: (BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle)),
                        child: photoFile == null
                            ? Icon(
                                Icons.person,
                                color: Colors.white,
                              )
                            : Image.file(
                                File(photoFile.path),
                                fit: BoxFit.fill,
                              )),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      child: customTextField(
                        obscureText: false,
                        labelText: AppLocalizations.of(context).name,
                        minLines: 1,
                        maxLines: 1,
                        controller: nameTextEditingController,
                        textInputType: TextInputType.name,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      child: customTextField(
                        obscureText: false,
                        labelText: AppLocalizations.of(context).email,
                        minLines: 1,
                        maxLines: 1,
                        controller: emailTextEditingController,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      child: customTextField(
                        obscureText: true,
                        labelText: AppLocalizations.of(context).password,
                        minLines: 1,
                        maxLines: 1,
                        controller: passWordTextEditingController,
                        textInputType: TextInputType.text,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(

                        onTap: () async {
                          setState(() {
                            isloading1 = true;
                          });
                          await checkInfoInput(context).whenComplete(() {
                            setState(() {
                              isloading1 = false;
                            });
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            height: 60.0,
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context).register,
                                    style: TextStyle(color: Colors.white))))),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).haveaccount,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(AppLocalizations.of(context).login,
                            style: TextStyle(
                                color: Colors.redAccent[700],
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  void addPhotoUser(ImageSource source, BuildContext context) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 200.0,
        maxHeight: 250.0,
        imageQuality: 50,
      );
      setState(() {
        photoFile = pickedFile;
      });
    } catch (ex) {
      print("ImageUserWrong::" + ex.toString());
    }
  }

  Future<void> checkInfoInput(BuildContext context) async {
    if (photoFile == null) {
      show(AppLocalizations.of(context).showimage);
    }
    if (nameTextEditingController == null) {
      show(AppLocalizations.of(context).showname);
    }

    if (emailTextEditingController == null) {
      show(
        AppLocalizations.of(context).show1,
      );
    }
    if (passWordTextEditingController == null) {
      show(AppLocalizations.of(context).show2);
    } else {
      setState(() {
        isloading1 = true;
      });
      _authService.setPhotoUserTOStorage(photoFile, userPhotoId, context);
    }
  }
}
