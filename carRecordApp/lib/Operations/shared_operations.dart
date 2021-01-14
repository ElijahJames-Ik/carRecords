import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedOperations {
  static Future<void> showMessage(
      GlobalKey<ScaffoldState> key, String message) async {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    key.currentState.showSnackBar(snackBar);
  }

  static Future<bool> checkConnectivity() {
    return Connectivity().checkConnectivity().then((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    });
  }

  static Future<void> saveFileLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('file_location', location);
  }

  static Future<String> getFileLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('file_location');
  }

/*
* function checks if the gender selected in the filter is the same as the gender of
* the carOwnerDataModel object being filtered.
* @return this function returns true if they are the same else it returns false
*/
  static bool checkGender(String genderFilter, String genderValue) {
    if (genderFilter == null || genderFilter.isEmpty || genderFilter == 'All') {
      return true;
    } else {
      if (genderFilter != null &&
          genderFilter.toLowerCase() == genderValue.toLowerCase()) {
        return true;
      } else {
        return false;
      }
    }
  }
}
