import 'package:flutter/cupertino.dart';

class NotifictionIndex extends ChangeNotifier{
  int index;
  countIndexNotifiction(int i){
    index=i;
    notifyListeners();
  }
}