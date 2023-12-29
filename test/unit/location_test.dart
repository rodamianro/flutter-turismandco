import "dart:convert";

import "package:flutter_test/flutter_test.dart";
import "package:turismandco/models/location.dart";

void main() {
  test('Test location deserialization dummy', () {
    const locationJSON =
        '{"name": "Kinkaku-ji", "url":"https://jp.openrice.com/userphoto/Article/0/1/0000CM2AF2F38CD85AB341j.jpg", "facts":[{"title": "Summary","text":"Kinkaku-ji, officially named Rokuon-ji, is a Zen Buddhist temple in Kyoto, Japan"}]}';
    final locationMap = jsonDecode(locationJSON) as Map<String, dynamic>;
    expect("Kinkaku-ji", equals(locationMap['name']));

    final location = Location.fromJson(locationMap);
    expect(location.name, matches(locationMap['name']));
    expect(location.url, matches(locationMap['url']));
    expect(location.facts![0].title, matches(locationMap['facts'][0]['title']));
    expect(location.facts![0].text, matches(locationMap['facts'][0]['text']));
  });

  test('test /locations and /locations/:id', () async {
    final locations = await Location.fetchAll();

    for (var location in locations) {
      expect(location.name, hasLength(greaterThan(0)));
      expect(location.url, hasLength(greaterThan(0)));

      final fetchedLocation = await Location.fetchByID(location.id);

      expect(fetchedLocation.name, equals(location.name));
      expect(fetchedLocation.url, equals(location.url));
    }
  });
}
