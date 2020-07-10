// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Match App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final SerializableFinder welcomeRegisterButtonFinder =
        find.byValueKey('welcomeRegisterButton');
    final SerializableFinder emailTextFieldFinder =
        find.byValueKey('registerEmail');
    final SerializableFinder passwordTextFieldFinder =
        find.byValueKey('registerPassword');
    final SerializableFinder submitButtonFinder =
        find.byValueKey('registerSubmitButton');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('start out without error text', () async {
      await driver.waitFor(welcomeRegisterButtonFinder);

      await Future<void>.delayed(const Duration(seconds: 1));

      await driver.tap(welcomeRegisterButtonFinder);

      await driver.waitFor(emailTextFieldFinder);

      await driver.tap(submitButtonFinder);

      await driver.tap(emailTextFieldFinder);

      await driver.enterText('sample@some.com');

      await driver.waitFor(submitButtonFinder);

      await driver.tap(submitButtonFinder);

      await driver.tap(passwordTextFieldFinder);

      await driver.enterText('password');

      await driver.tap(submitButtonFinder);

      expect(1, 1);
    });

    // test('increments the counter', () async {
    //   // First, tap the button.
    //   await driver.tap(buttonFinder);

    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(emailTextFieldFinder), "1");
    // });
  });
}
