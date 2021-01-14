import 'dart:convert';

import 'package:carRecordApp/Operations/shared_operations.dart';
import 'package:carRecordApp/model/filter_data_user_model.dart';
import 'package:carRecordApp/model/user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserOperations {
  /*
  * This Function gets json data from the API and converts it
  * to a list of UserDataModel objects.
  * @return this function returns List of UserDataModel if the
  * operation is successful else it returns null
  */
  static Future<List<UserDataModel>> getUserDataFromAPI(
      GlobalKey<ScaffoldState> key) {
    return SharedOperations.checkConnectivity().then((result) {
      if (result) {
        String apiUrl = 'https://android-json-test-api.herokuapp.com/accounts';
        final headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };

        return http
            .get(Uri.encodeFull(apiUrl), headers: headers)
            .timeout(Duration(seconds: 15), onTimeout: () {
          SharedOperations.showMessage(key, 'Connection timed out');
          return null;
        }).then((response) {
          if (response != null) {
            int statusCode = response.statusCode;
            if (statusCode == 200) {
              try {
                var body = json.decode(response.body) as List;

                return body
                    .map((json) =>
                        UserDataModel.fromJson(json as Map<String, dynamic>))
                    .toList();
              } catch (error) {
                print(error.toString());
                SharedOperations.showMessage(
                    key, 'An error occured parse json resource');
                return null;
              }
            } else {
              return null;
            }
          } else {
            return null;
          }
        });
      } else {
        SharedOperations.showMessage(key, 'You are offline');
        return null;
      }
    });
  }

  static List<UserDataModel> filterUsersList(
      List<UserDataModel> list, FilterUserModel filters) {
    return list.where((element) {
      if (checkCountries(filters.countries, element.countryList) &&
          checkColor(filters.colors, element.colorList) &&
          SharedOperations.checkGender(filters.gender, element.gender)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  static bool checkCountries(List<String> countries, List<String> countryList) {
    if (countries == null || countries.length == 0) {
      return true;
    } else {
      if (countryList == null || countryList.length == 0) {
        return false;
      }
      if (countries.length > 0) {
        countryList = countryList.map((e) => e.toLowerCase().trim()).toList();
        for (String country in countries) {
          if (!countryList.contains(country.toLowerCase().trim())) {
            return false;
          }
        }
        return true;
      } else {
        return false;
      }
    }
  }

  static bool checkColor(List<String> colors, List<String> colorList) {
    if (colors == null || colors.length == 0) {
      return true;
    } else {
      if (colorList == null || colorList.length == 0) {
        return false;
      }
      colorList = colorList.map((e) => e.toLowerCase().trim()).toList();
      if (colorList.length > 0) {
        for (String color in colors) {
          if (!colorList.contains(color.toLowerCase().trim())) {
            return false;
          }
        }
        return true;
      } else {
        return false;
      }
    }
  }
}
