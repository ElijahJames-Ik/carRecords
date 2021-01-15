import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('open user list page', () {
    final usersPageButton = find.byValueKey('Users Page');
    final carsPageButton = find.text('Cars Page');
    final backButton = find.pageBack();
    final allowButton = find.text('Allow');
    final file = find.text('car_ownsers_data.csv');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        //driver.close();
      }
    });

    test('goto cars page and load csv file', () async {
      await driver.tap(usersPageButton);
      await driver.tap(allowButton);
      await driver.tap(file);
    });
  });
}
