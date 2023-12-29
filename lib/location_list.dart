import 'package:flutter/material.dart';
import 'package:turismandco/location_detail.dart';
import 'package:turismandco/models/location.dart';
import 'package:turismandco/styles.dart';

class LocationsList extends StatefulWidget {
  const LocationsList({super.key});
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationsList> {
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  loadData() async {
    final locations = await Location.fetchAll();
    setState(() {
      this.locations = locations;
    });
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var location = locations[index];
    return ListTile(
      contentPadding: const EdgeInsets.all(10.0),
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      onTap: () => _navigationToLocationDetail(context, location.id),
    );
  }

  void _navigationToLocationDetail(BuildContext context, int locationID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationDetail(locationID: locationID),
      ),
    );
  }

  Widget _itemThumbnail(Location location) {
    Image image = Image.network(
      location.url,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        return const Image(
          image: AssetImage('assets/images/placeholder.png'),
          fit: BoxFit.fitWidth,
        );
      },
    );
    return Container(
      constraints: const BoxConstraints.tightFor(width: 100.0),
      child: image,
    );
  }

  Widget _itemTitle(Location location) {
    return Text(location.name, style: Styles.textDefault);
  }
}
