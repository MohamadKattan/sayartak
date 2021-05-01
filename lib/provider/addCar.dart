import 'package:flutter/cupertino.dart';
import 'package:sayartak/model/sale_car_model.dart';

class AddCar extends ChangeNotifier {
  SaleCar saleCar;
  String carIdd;
  updateAddCar(SaleCar car) {
    saleCar = car;
    notifyListeners();
  }

  updateAddCarId(String carId) {
    carIdd = carId;
    notifyListeners();
  }
}
