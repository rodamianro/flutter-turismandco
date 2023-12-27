import "package:flutter_test/flutter_test.dart";
import "package:network_image_mock/network_image_mock.dart";
import "package:turismandco/app.dart";
import "package:turismandco/mocks/mock_location.dart";

void main() {
  testWidgets(
    'Test app Startup',
    (WidgetTester tester) async {
      mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(const App());

          final mockLocation = MockLocation.fetchAny();
          expect(find.text(mockLocation.name), findsOneWidget);
          expect(find.text('${mockLocation.name}blash'), findsNothing);
        },
      );
    },
  );
}
