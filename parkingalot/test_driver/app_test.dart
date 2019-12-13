import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//To run (in terminal): flutter drive --target=test_driver/app.dart

void main() {
  group('Parking app',() {

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });



    test('ask credentials', () async {
      await driver.tap(find.byValueKey('gotoreg'));

      await driver.waitFor(find.byType('RegisterPage'));
    });

    test('create account', () async {
      await driver.tap(find.byValueKey('gotoreg'));
      await driver.enterText('User');
    });

  });
}