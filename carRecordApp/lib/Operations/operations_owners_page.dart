import 'dart:convert';
import 'dart:io';

import 'package:carRecordApp/Operations/shared_operations.dart';
import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:carRecordApp/model/filter_data_model.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OperationsOwnersPage {
  static Future<PlatformFile> getCSVFile(
      GlobalKey<ScaffoldState> key, AppProvider provider) async {
    return await FilePicker.platform
        .pickFiles(
            allowMultiple: false,
            allowedExtensions: ['csv'],
            type: FileType.custom)
        .then((response) {
      if (response != null) {
        if (response.files.first.name == 'car_ownsers_data.csv') {
          SharedOperations.saveFileLocation(response.files.first.path);
          return response.files.first;
        } else {
          provider.isLoadingCarsPage = false;
          SharedOperations.showMessage(
              key, 'Invalid csv file, please open car_ownsers_data.csv');
          return null;
        }
      }
      return null;
    }).catchError((onError) {
      provider.isLoadingCarsPage = false;
      SharedOperations.showMessage(key, 'Couldn\'t open file');

      return null;
    });
  }

  static void decodeCSVFile(PlatformFile file, AppProvider provider,
      GlobalKey<ScaffoldState> key) async {
    final input = new File(file.path).openRead();
    List<CarOwnerDataModel> ownersList = new List<CarOwnerDataModel>();
    try {
      input.transform(utf8.decoder).transform(new LineSplitter()).listen(
          (String line) {
        List row = line.split(new RegExp(',(?=(?:[^\"]*\"[^\"]*\")*[^\"]*\$)'));
        var data = CarOwnerDataModel.fromList(row);
        if (row[0] != 'id') {
          ownersList.add(data);
        } else {
          // if (row == null || row.length < 10 || row.length > 10) {
          //   SharedOperations.showMessage(key, 'Couldn\'t parse csv file');
          //   provider.isLoadingCarsPage = false;
          // }
        }
      }, onDone: () {
        provider.ownersDataList = ownersList;
        provider.ownersDataListCopy = ownersList;
        provider.isLoadingCarsPage = false;
      }, onError: (error) {
        SharedOperations.showMessage(key, 'Couldn\'t parse csv file');
        provider.ownersDataList = null;
        provider.ownersDataListCopy = null;
        provider.isLoadingCarsPage = false;
      });
    } catch (ex) {
      SharedOperations.showMessage(key, 'Couldn\'t parse csv file');
      provider.isLoadingCarsPage = false;
    }
  }

  static List<CarOwnerDataModel> filterOwnersList(
      List<CarOwnerDataModel> list, FilterModel filters) {
    print(filters.fromYear);
    print(filters.toYear);
    return list.where((element) {
      // print(element.carModelYear);
      // print(element.carModel);
      if (checkCountries(filters.countries, element.country) &&
          checkColor(filters.colors, element.carColor) &&
          checkGender(filters.gender, element.gender) &&
          checkDateFrom(filters.fromYear, element.carModelYear) &&
          checkDateTo(filters.toYear, element.carModelYear)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  static bool checkCountries(List<String> countries, String countryValue) {
    if (countries == null || countries.length == 0) {
      return true;
    } else {
      if (countries.length > 0 &&
          countries
                  .where((country) {
                    if (country.toLowerCase() == countryValue.toLowerCase()) {
                      return true;
                    } else {
                      return false;
                    }
                  })
                  .toList()
                  .length >
              0) {
        return true;
      } else {
        return false;
      }
    }
  }

  static bool checkColor(List<String> colors, String colorValue) {
    if (colors == null || colors.length == 0) {
      return true;
    } else {
      if (colors.length > 0 &&
          colors
                  .where((color) {
                    if (color.toLowerCase() == colorValue.toLowerCase()) {
                      return true;
                    } else {
                      return false;
                    }
                  })
                  .toList()
                  .length >
              0) {
        return true;
      } else {
        return false;
      }
    }
  }

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

  static bool checkDateFrom(String dateFilter, String dateValue) {
    if (dateFilter == null || dateFilter.isEmpty) {
      return true;
    } else {
      int fromDate = int.parse(dateFilter);
      int date = int.parse(dateValue);
      if (date >= fromDate) {
        return true;
      } else {
        return false;
      }
    }
  }

  static bool checkDateTo(String dateFilter, String dateValue) {
    if (dateFilter == null || dateFilter.isEmpty) {
      return true;
    } else {
      int toDate = int.parse(dateFilter);
      int date = int.parse(dateValue);
      if (date <= toDate) {
        return true;
      } else {
        return false;
      }
    }
  }
}
