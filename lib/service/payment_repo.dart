import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sayartak/all_screens/main_screen.dart';
import 'package:sayartak/model/payment_model.dart';
import 'package:sayartak/service/set_car_fireStore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentRepo {
  static var _urlPayment = Uri.parse("https://api.sandbox.checkout.com/payments");
  static var urlToken = Uri.parse("https://api.sandbox.checkout.com/tokens");
  static const _secretKey = "sk_test_60367d76-4194-48b8-bc3e-72ed5b863e76";
  static const _publicKey = "pk_test_f86de012-0b0a-4141-a371-3665278814e5";
  static const Map<String, String> _tokenHeader = {
    "Content-Type": "application/json",
    "Authorization": _publicKey,
  };
  static const Map<String, String> _payHeader = {
    "Content-Type": "application/json",
    "Authorization": _secretKey,
  };

  // this method for check if card user right or not and got token
  Future<String> _getToken(PaymentCard card) async {
    Map<String, dynamic> body = {
      "type": "card",
      "number": card.number,
      "expiry_month": card.expiryMonth,
      "expiry_year": card.expiryYear,
      "cvv": card.ccv,
    };
    http.Response response = await http.post(urlToken,
        headers: _tokenHeader, body: jsonEncode(body));
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return data['token'];
    } else {
      print('Request TOKEN failed with status: ${response.statusCode}.');
    }
    return null;
  }

  Future<bool> makePayment(
      PaymentCard card,
      int amount,
      String currency,
      BuildContext context,
     PickedFile file,
      bool installment,
      String dropdownValue) async {
    var token = await _getToken(card);
    print("this token:::" + token.toString());
    Map<String, dynamic> body = {
      "source": {"type": "token", "token": token},
      "amount": amount,
      "currency": currency,
    };
    http.Response response = await http.post(_urlPayment,
        headers: _payHeader, body: jsonEncode(body));
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data["response_summary"]);
      SetCarTOFireStore store = SetCarTOFireStore();
      store.upLoadToStorage(context, file, installment, dropdownValue);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    } else {
      show(AppLocalizations.of(context).checkcard);
      print('Request payment failed with status: ${response.statusCode}.');
    }
    return null;
  }

  // this method for show flutter toast
  Future<void> show(String msg) async {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
