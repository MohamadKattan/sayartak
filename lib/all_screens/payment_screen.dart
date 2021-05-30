import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/main_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/payment_model.dart';
import 'package:sayartak/service/payment_repo.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
    final  PickedFile image;
  final String dropdownValue;
  final bool installment;
  const PaymentScreen(
      {Key key, this.dropdownValue, this.image, this.installment})
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
        body: SafeArea(
          child: Stack(
            children: [
              _isLoading ? CustomCircular() : Text(""),
              SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(height: 10),
                  CreditCard(
                    cardNumber: cardNumber,
                    cardExpiry: "${expiryDateMouthe+"/"+expiryDateYear}",
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
                      decoration: InputDecoration(hintText:AppLocalizations.of(context).cardnumber),
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
                      decoration: InputDecoration(hintText:AppLocalizations.of(context).moutheexpiry),
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
                      decoration: InputDecoration(hintText:AppLocalizations.of(context).yearexpiry),
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
                      decoration: InputDecoration(hintText:AppLocalizations.of(context).holdername),
                      maxLength: 19,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        setState(() {
                          cardHolderName = value;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                          child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                AppLocalizations.of(context).pay,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.green[700]),
                              )),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            PaymentCard card = PaymentCard(
                                ccv: cvv,
                                number: cardNumber,
                                expiryMonth: expiryDateMouthe,
                                expiryYear: expiryDateYear);
                            PaymentRepo _repo = PaymentRepo();
                            await _repo.makePayment(
                                card,
                                1000,
                                "USD",
                                context,
                                widget.image,
                                widget.installment,
                                widget.dropdownValue);
                            setState(() {
                              _isLoading = false;
                            });

                          }),
                      RaisedButton(
                          child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                AppLocalizations.of(context).cancel,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.redAccent[700]),
                              )),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () async {
                          await  clearList();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
  clearList() {
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
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
    print("clear and pop");
  }
}
