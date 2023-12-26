import 'package:flutter/material.dart';
import 'package:turismandco/location_list.dart';
import 'package:turismandco/mocks/mock_location.dart';

void main() {
  return runApp(MaterialApp(
    home: LocationList(
      locations: MockLocation.fetchAll(),
    ),
  ));
}
