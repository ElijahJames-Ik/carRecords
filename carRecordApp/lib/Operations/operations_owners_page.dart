import 'dart:convert';
import 'dart:io';

import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:carRecordApp/model/filter_data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';

class OperationsOwnersPage {
  static Future<PlatformFile> getCSVFile() async {
    return await FilePicker.platform
        .pickFiles(
            allowMultiple: false,
            allowedExtensions: ['csv'],
            type: FileType.custom)
        .then((response) {
      if (response != null) {
        return response.files.first;
      }
      return null;
    });
  }

  static List<CarOwnerDataModel> decodeCSVFile(PlatformFile file) {
    final input = new File(file.path).openRead();
    List<CarOwnerDataModel> ownersList = new List<CarOwnerDataModel>();

    input
        .transform(utf8.decoder)
        .transform(new LineSplitter())
        .listen((String line) {
      List row = line.split(new RegExp(',(?=(?:[^\"]*\"[^\"]*\")*[^\"]*\$)'));
      var data = CarOwnerDataModel.fromList(row);
      if (row[0] != 'id') {
        ownersList.add(data);
      }
    }).onError((error) {
      return null;
    });
    return ownersList;
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
                    if (color.toLowerCase() == color.toLowerCase()) {
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
