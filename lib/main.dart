import 'package:flutter/material.dart';
import 'package:turismandco/mocks/mock_location.dart';
import 'package:turismandco/models/location.dart';
import 'location_detail.dart';

void main() {
  final Location location = MockLocation.FetchAny();
  return runApp(MaterialApp(
    home: LocationDetail(
      location: location,
    ),
  ));
}
