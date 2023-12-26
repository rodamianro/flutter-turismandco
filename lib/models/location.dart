import "location_fact.dart";

class Location {
  final String name;
  final String url;
  final List<LocationFact> facts;

  const Location({required this.name, required this.url, required this.facts});
}
