import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          location.name,
          style: Styles.navBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, location),
        ),
      ),
    );
  }

  loadData() async {
    final location = await Location.fetchByID(widget.locationID);
    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  List<Widget> _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(_bannerImage(location.url, 170));
    result.addAll(_renderFacts(context, location));
    return result;
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

  Widget _bannerImage(String url, double height) {
    Image? image;
    if (url.isNotEmpty) {
      image = Image.network(
        url,
        fit: BoxFit.fitWidth,
      );
    }
    return Container(
        constraints: BoxConstraints.tightFor(height: height), child: image);
  }

  Widget _section(String title, Color color) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Text(title),
    );
  }
}
