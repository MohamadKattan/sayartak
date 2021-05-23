import 'dart:io';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/main_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/payment_model.dart';
import 'package:sayartak/service/payment_repo.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

var uuid = Uuid();

class PaymentScreen extends StatefulWidget {
  final PickedFile imageFile1;
  final PickedFile videoFile;
  final String dropdownValue1;
  final bool installment1;
  const PaymentScreen(
      {Key key,
      this.installment1,
      this.dropdownValue1,
      this.imageFile1,
      this.videoFile})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDateMouthe = "";
  String expiryDateYear = "";
  String cvv = "";
  bool showBack = false;
  FocusNode _focusNode;
  String carId = uuid.v1();
  bool _isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: formKey,
        appBar: AppBar(
          title: Text(" PaymentScreen"),
          centerTitle: false,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _isLoading ? CustomCircular() : Text(""),
              SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(height: 10),
                  CreditCard(
                    cardNumber: cardNumber,
                    cardExpiry: "${expiryDateMouthe + expiryDateYear}",
                    cvv: cvv,
                    cardHolderName: cardHolderName,
                    showBackSide: showBack,
                    frontBackground: CardBackgrounds.black,
                    backBackground: CardBackgrounds.white,
                    showShadow: true,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Card Number"),
                      maxLength: 16,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Cvv"),
                      maxLength: 3,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          cvv = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Mouthe Expiry"),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          expiryDateMouthe = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Year expiry"),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          expiryDateYear = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Holder Name"),
                      maxLength: 19,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        setState(() {
                          cardHolderName = value;
                        });
                      },
                    ),
                  ),
                  RaisedButton(
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Pay",
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          )),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () async {
                        PaymentCard card = PaymentCard(
                            ccv: cvv,
                            number: cardNumber,
                            expiryMonth: expiryDateMouthe,
                            expiryYear: expiryDateYear);
                        PaymentRepo _repo = PaymentRepo();
                        await _repo.makePayment(card, 1000, "USD");
                        await upLoadToStorage().whenComplete(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        });
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                ]),
              ),
            ],
          ),
        ));
  }

  // this method for upload image to Storage
  Future<void> upLoadToStorage() async {
    try {
      setState(() {
        _isLoading = true;
      });
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('car')
          .child(carId);
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(widget.imageFile1.path));
      String url = await uploadTask.then((url) {
        return ref.getDownloadURL();
      });
      print("don in storage now to firestore::::" + uploadTask.toString());
      await downloadUrl(url);
    } catch (exStorage) {
      print("errorUploadStorage:::" + exStorage.toString());
    }
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
        "statusCar": widget.dropdownValue1.toString(),
        "installment": widget.installment1 ? "Available" : "Not available",
      });
      print("don upload data to cloud");
      setState(() {
        _isLoading = false;
      });
    } catch (ex) {
      show("some thing went wrong");
      print("errorUploadToFirestore::" + ex.toString());
    }
  }
}
