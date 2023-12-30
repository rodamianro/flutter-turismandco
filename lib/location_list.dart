import 'package:flutter/material.dart';
import 'package:turismandco/components/location_tile.dart';
import 'package:turismandco/components/progress_bar.dart';
import 'package:turismandco/location_detail.dart';
import 'package:turismandco/models/location.dart';
import 'package:turismandco/styles.dart';

const double listItemHeight = 245.0;
const double listItemFooterHeight = 90.0;

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
            _tileImage(location.url, MediaQuery.of(context).size.width,
                listItemHeight),
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
          vertical: 5.0, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      height: listItemFooterHeight,
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }

  Widget _tileImage(String url, double width, double height) {
    Image image = Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Image(
          image: AssetImage('assets/images/placeholder.png'),
          fit: BoxFit.cover,
        );
      },
    );
    return Container(
      constraints: const BoxConstraints.expand(),
      child: image,
    );
  }

  Widget _itemTitle(Location location) {
    return Text(location.name, style: Styles.textDefault);
  }
}
