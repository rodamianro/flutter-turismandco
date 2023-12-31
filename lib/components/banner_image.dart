import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  final String url;
  final double height;

  const BannerImage({super.key, required this.url, this.height = 245.0});

  @override
  Widget build(BuildContext context) {
    Image? image;
    if (url.isNotEmpty) {
      image = Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Image(
            image: AssetImage('assets/images/placeholder.png'),
            fit: BoxFit.cover,
          );
        },
      );
    }
    return Container(
      constraints: BoxConstraints.expand(height: height),
      child: image,
    );
  }
}
