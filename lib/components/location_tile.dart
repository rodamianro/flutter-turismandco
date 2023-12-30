import 'package:flutter/material.dart';
import 'package:turismandco/models/location.dart';
import 'package:turismandco/styles.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final bool darkTheme;
  const LocationTile(
      {super.key, required this.location, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    final String title = location.name.toUpperCase();
    final String subTitle = location.userItinerarySummary.toUpperCase();
    final String caption = location.tourPackageName.toUpperCase();

    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: darkTheme
                ? Styles.locationTileTitleDark
                : Styles.locationTileTitleLight,
          ),
          Text(subTitle, style: Styles.locationTileSubtitle),
          Text(caption, style: Styles.locationTileCaption)
        ],
      ),
    );
  }
}
