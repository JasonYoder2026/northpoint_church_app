import 'package:flutter_test/flutter_test.dart';
import 'package:northpoint_church_app/features/splash/splash_page.dart';

void main() {
  group('shouldNavigateToHome', () {
    test('returns true for the splash route', () {
      expect(shouldNavigateToHome('/'), isTrue);
    });

    test(
      'returns false once the app has already navigated away from splash',
      () {
        expect(shouldNavigateToHome('/event-details'), isFalse);
      },
    );
  });
}
