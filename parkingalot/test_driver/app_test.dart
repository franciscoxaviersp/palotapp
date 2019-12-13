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
      await driver.tap(find.byValueKey('userkey'));
      await driver.enterText('User');
      await driver.tap(find.byValueKey('passkey'));
      await driver.enterText('Pass');
      await driver.tap(find.byValueKey('regbtn'));

      await driver.waitFor(find.byValueKey('Alert'));
      await driver.tap(find.byValueKey('close'));

    });

    test('login wrong pass', () async {
      await driver.tap(find.byValueKey('userkey'));
      await driver.enterText('User');
      await driver.tap(find.byValueKey('passkey'));
      await driver.enterText('');
      await driver.tap(find.byValueKey('logbtn'));

      await driver.waitFor(find.byValueKey('badpassAlert'));
      await driver.tap(find.byValueKey('close'));
    });

    test('login right pass', () async {
      await driver.tap(find.byValueKey('passkey'));
      await driver.enterText('Pass');
      await driver.tap(find.byValueKey('logbtn'));

      await driver.waitFor(find.byType('HomePage'));
    });

    test('find parks', () async {
      await driver.waitFor(find.byValueKey('onePark'));
      await driver.tap(find.byValueKey('onePark'));

      await driver.tap(find.byType('Parque'));
    });

  });
}