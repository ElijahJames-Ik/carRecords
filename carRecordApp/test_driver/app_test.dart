import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('open user list page', () {
    final usersPageButton = find.byValueKey('Users Page');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('goto cars page', () async {
      await driver.tap(usersPageButton);
    });
  });
}
