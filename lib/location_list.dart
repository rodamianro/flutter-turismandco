import 'package:flutter/material.dart';
import 'package:turismandco/models/location.dart';
import 'package:turismandco/styles.dart';

class LocationList extends StatelessWidget {
  final List<Location> locations;
  const LocationList({super.key, required this.locations});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Locations',
          style: Styles.navBarTitle,
        ),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            leading: _itemThumbnail(locations[index]),
            title: _itemTitle(locations[index]),
          );
        },
      ),
    );
  }

  Widget _itemThumbnail(Location location) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 100.0),
      child: Image.network(location.url, fit: BoxFit.fitWidth),
    );
  }

  Widget _itemTitle(Location location) {
    return Text(location.name, style: Styles.textDefault);
  }
}
