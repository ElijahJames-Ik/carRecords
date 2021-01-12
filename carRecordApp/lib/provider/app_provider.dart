import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider with ChangeNotifier {
  CarOwnerDataModel _ownerData;

  CarOwnerDataModel get ownerData => _ownerData;

  set ownerData(CarOwnerDataModel data) {
    _ownerData = data;
    notifyListeners();
  }
}
