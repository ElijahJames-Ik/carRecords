import 'dart:convert';
import 'dart:io';

import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';

class Operations {
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
      List row = line.split(',');
      ownersList.add(CarOwnerDataModel.fromList(row));
    }).onError((error) {
      return null;
    });
    return ownersList;
  }
}
