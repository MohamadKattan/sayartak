import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUserProvider extends ChangeNotifier {
  User user;
  getProviderCurrentUser(User currentUser) {
    user = currentUser;
    notifyListeners();
  }
}
