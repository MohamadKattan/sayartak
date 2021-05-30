import 'package:flutter/cupertino.dart';

class LikeProvider extends ChangeNotifier{
  String likePro;
  updateLikePro(String like){
    likePro=like;
    notifyListeners();
  }
}
