import 'package:flutter/material.dart';
import 'package:turismandco/components/banner_image.dart';
import 'package:turismandco/components/default_app_bar.dart';
import 'package:turismandco/components/location_tile.dart';
import 'package:turismandco/components/progress_bar.dart';
import 'package:turismandco/models/location.dart';
import 'package:turismandco/styles.dart';

class LocationDetail extends StatefulWidget {
  final int locationID;
  const LocationDetail({super.key, required this.locationID});

  @override
  createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  Location location = Location.blank();
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
        child: Stack(
          children: [
            _renderBody(context, location),
            _renderFooter(context, location),
            _renderProgressBar(context),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
      final location = await Location.fetchByID(widget.locationID);
      setState(() {
        this.location = location;
        loading = false;
      });
    }
  }

  Widget _renderProgressBar(BuildContext context) {
    return (loading ? const DefaultProgressBar() : Container());
  }

  Widget _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(BannerImage(url: location.url, height: 300));
    result.add(_renderHeader(location));
    result.addAll(_renderFacts(context, location));
    result.add(_renderBottomSpacer());
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: result,
          ),
        )
      ],
    );
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = <Widget>[];
    if (location.facts != null) {
      for (int i = 0; i < location.facts!.length; i++) {
        result.add(_sectionTitle(location.facts![i].title));
        result.add(_sectionText(location.facts![i].text));
      }
    }
    return result;
  }

  Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      child: Text(title, textAlign: TextAlign.left, style: Styles.headerLarge),
    );
  }

  Widget _sectionText(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      child: Text(
        title,
        style: Styles.textDefault,
      ),
    );
  }

  Widget _renderHeader(Location location) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: Styles.horizontalPaddingDefault,
      ),
      child: LocationTile(
        darkTheme: false,
        location: location,
      ),
    );
  }

  Widget _renderFooter(BuildContext context, Location location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
          height: 100.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: _renderBookButton(),
          ),
        )
      ],
    );
  }

  Widget _renderBookButton() {
    return TextButton(
      onPressed: _buttonAction,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: const Text('BOOK'),
    );
  }

  void _buttonAction() {}

  Widget _renderBottomSpacer() {
    return Container(
      height: 100,
    );
  }
}
