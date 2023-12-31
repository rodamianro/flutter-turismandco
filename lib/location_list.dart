import 'package:flutter/material.dart';
import 'package:turismandco/components/banner_image.dart';
import 'package:turismandco/components/location_tile.dart';
import 'package:turismandco/components/progress_bar.dart';
import 'package:turismandco/location_detail.dart';
import 'package:turismandco/models/location.dart';
import 'package:turismandco/styles.dart';
import 'package:turismandco/components/default_app_bar.dart';

const double listItemHeight = 245.0;

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
      appBar: DefaultAppBar(),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: Column(
          children: [
            _renderProgressBar(context),
            Expanded(
              child: _renderListView(context),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
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
    return GestureDetector(
      onTap: () => _navigationToLocationDetail(context, location.id),
      child: SizedBox(
        height: listItemHeight,
        child: Stack(
          children: [
            BannerImage(url: location.url, height: listItemHeight),
            _tileFooter(location),
          ],
        ),
      ),
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

  Widget _tileFooter(Location location) {
    final info = LocationTile(
      location: location,
      darkTheme: true,
    );
    final overlay = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: Styles.horizontalPaddingDefault,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      // height: listItemFooterHeight,
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }
}
