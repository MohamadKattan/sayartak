import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sayartak/model/payment_model.dart';

class PaymentRepo {
  static const _urlPayment = "https://api.sandbox.checkout.com/payments";
  static const urlToken = "https://api.sandbox.checkout.com/tokens";
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
      "number":  card.number,
      "expiry_month": card.expiryMonth,
      "expiry_year": card.expiryYear,
      "cvv":  card.ccv,
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

  Future<bool> makePayment( PaymentCard card,int amount,String currency) async {
    var token = await _getToken(card);
    print("this token:::" + token.toString());
    Map<String, dynamic> body = {
      "source": {"type": "token", "token": token},
      "amount": amount,
      "currency":currency,
    };
    http.Response response = await http.post(_urlPayment,
        headers: _payHeader, body: jsonEncode(body));
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data["response_summary"]);
      return true;
    } else {
      print('Request payment failed with status: ${response.statusCode}.');
    }
    return null;
  }
}
