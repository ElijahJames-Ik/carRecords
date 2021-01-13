import 'dart:convert';

import 'package:carRecordApp/Operations/shared_operations.dart';
import 'package:carRecordApp/model/user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserOperations {
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
}
