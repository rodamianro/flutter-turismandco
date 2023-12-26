import 'package:flutter_test/flutter_test.dart';
import 'package:turismandco/mocks/mock_location.dart';

void main() {
  test('Test for: MockLocation -> fetchAny()', () {
    final mockLocation = MockLocation.fetchAny();
    expect(mockLocation, isNotNull);
    expect(mockLocation.name, isNotEmpty);
  });
  test('Test for: MockLocation -> fetchAll()', () {
    final mockLocation = MockLocation.fetchAll();
    expect(mockLocation.length, greaterThan(0));
    expect(mockLocation[0].name, isNotEmpty);
  });
  test('Test for: MockLocation -> fetch()', () {
    final mockLocation = MockLocation.fetch(0);
    expect(mockLocation, isNotNull);
    expect(mockLocation.name, isNotEmpty);
  });
}
