import 'package:flutter/material.dart';
import 'package:turismandco/components/progress_bar.dart';
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
  bool loading = false;

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
      body: Column(
        children: [
          _renderProgressBar(context),
          Expanded(
            child: _renderListView(context),
          )
        ],
      ),
    );
  }

  loadData() async {
    if (mounted) {
      setState(() => loading = true);
      final locations = await Location.fetchAll();
      setState(() {
        this.locations = locations;
        loading = false;
      });
    }
  }

  Widget _renderListView(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: _listViewItemBuilder,
    );
  }

  Widget _renderProgressBar(BuildContext context) {
    return (loading ? const DefaultProgressBar() : Container());
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
