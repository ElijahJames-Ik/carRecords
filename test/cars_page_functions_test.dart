import 'dart:io';

import 'package:carRecordApp/Operations/operations_owners_page.dart';
import 'package:carRecordApp/model/filter_data_car_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test cars page function', () async {
    File file = File('./test_resources/car_ownsers_data.csv');
    var list = await OperationsOwnersPage.decodeCSV(file);
    print(list.length);
    expect(list.length, 65499);

    var filters = new FilterCarModel(
        colors: ['Orange'],
        countries: ['China', 'Nigeria'],
        fromYear: '1990',
        toYear: '2004',
        gender: 'Male',
        model: 'Honda');

    var filteredList = OperationsOwnersPage.filterOwnersList(list, filters);
    print(filteredList.length);
    expect(filteredList.length, 3);
  });
}
