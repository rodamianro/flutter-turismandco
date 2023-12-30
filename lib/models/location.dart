import "dart:convert";
import "package:turismandco/endpoint.dart";
import "location_fact.dart";
import "package:json_annotation/json_annotation.dart";
import "dart:async";
import 'package:http/http.dart' as http;

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final String userItinerarySummary;
  final String tourPackageName;
  final List<LocationFact>? facts;

  const Location({
    required this.id,
    required this.name,
    required this.url,
    required this.userItinerarySummary,
    required this.tourPackageName,
    this.facts,
  });

  Location.blank()
      : id = 0,
        name = '',
        url = '',
        facts = [],
        userItinerarySummary = '',
        tourPackageName = '';

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/locations');

    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw (res.body);
    }
    List<Location> list = <Location>[];
    for (var jsonItem in jsonDecode(res.body)) {
      list.add(Location.fromJson(jsonItem));
    }
    return list;
  }

  static Future<Location> fetchByID(int id) async {
    var uri = Endpoint.uri('/locations/$id');

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw (res.body);
    }
    return Location.fromJson(jsonDecode(res.body));
  }
}
