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

      //expect(find.byType('RegisterPage'),findsOneWidget);
      await driver.waitFor(find.byType('RegisterPage'));
    });

  });
}