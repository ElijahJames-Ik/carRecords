import 'dart:convert';
import 'dart:io';

import 'package:carRecordApp/Operations/shared_operations.dart';
import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:carRecordApp/model/filter_data_car_model.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OperationsOwnersPage {
  /*
  * File picker set to allow the user pick one csv file
  * @return PlatformFile Object if a csv file is selected
  * else return null if no file is selected or the file name
  * isn't car_ownsers_data.csv or if an error occurs
  */
  static Future<PlatformFile> getCSVFile(
      GlobalKey<ScaffoldState> key, AppProvider provider) async {
    return await Permission.storage.isPermanentlyDenied.then((status) async {
      if (status) {
        provider.isLoadingCarsPage = false;
        SharedOperations.showMessage(key,
            'You have permanently denied access for this application, goto to app settings to grant access');
        return null;
      } else {
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
          var data = onError as PlatformException;
          if (data.message == 'User did not allowed reading external storage') {
            SharedOperations.showMessage(key,
                'User did not allow reading external storage, check app settings');
          } else {
            SharedOperations.showMessage(key, 'Couldn\'t open file');
          }

          provider.isLoadingCarsPage = false;
          return null;
        });
      }
    });
  }

  /*
  * Accepts a PlatformFile and AppProvider object as input
  * parses the PlatformFile as a csv file and converts the 
  * rows to CarOwnerDataModel Object, once the parsing operation
  * is done the AppProvider object sets ownersDataList and ownersDataListCopy
  * to the List of CarOwnerDataModel objects created from parsing the csv file.
  * this allows for the data to be displayed in the cars page since ownersDataList
  * is used as the data list for displayed the parsed data from the csv file.
  */
  static void decodeCSVFile(PlatformFile file, AppProvider provider,
      GlobalKey<ScaffoldState> key) async {
    provider.isLoadingCarsPage = true;
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

  /*
  * Accepts List of CarOwnerDataModel to filtered and filterModel
  * that contains filter settings, this function creates a new list
  * of CarOwnerDataModel based on the filterModel properties.
  * @return this function the filtered List of CarOwnerDataModel
  */
  static List<CarOwnerDataModel> filterOwnersList(
      List<CarOwnerDataModel> list, FilterCarModel filters) {
    print(filters.fromYear);
    print(filters.toYear);
    return list.where((element) {
      // print(element.carModelYear);
      // print(element.carModel);
      if (checkCountries(filters.countries, element.country) &&
          checkColor(filters.colors, element.carColor) &&
          checkCarModel(filters.model, element.carModel) &&
          SharedOperations.checkGender(filters.gender, element.gender) &&
          checkDateFrom(filters.fromYear, element.carModelYear) &&
          checkDateTo(filters.toYear, element.carModelYear)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  /*
  * function checks if the carOwnerDataModel object date is equal to or greated than the start
  * date from the filterModel object.
  * @return this function returns true if the condition is met else returns null
  */
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

  /*
  * function checks if the carOwnerDataModel object date is less than or equal to the end
  * date from the filterModel object.
  * @return this function returns true if the condition is met else returns null
  */
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

  /*
  * function for check if country is in a list of country from filtering data
  * to be used in the filterOwnersList function.
  * @return this function returns true if the countryValue is present in the 
  * countries list. else it returns false
  */
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

/*
  * function for check if color is in a list of colors from filtering data
  * to be used in the filterOwnersList function.
  * @return this function returns true if the colorValue is present in the 
  * colors list. else it returns false
  */
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

  static bool checkCarModel(String modelFilter, String modelValue) {
    if (modelFilter == null || modelFilter.isEmpty) {
      return true;
    } else {
      if (modelFilter != null &&
          modelFilter.toLowerCase() == modelValue.toLowerCase()) {
        return true;
      } else {
        return false;
      }
    }
  }
}
