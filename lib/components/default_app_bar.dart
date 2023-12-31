import 'package:flutter/material.dart';
import 'package:turismandco/styles.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar({
    super.key,
    super.title = const Text(
      "Tourims & Co.",
      style: Styles.navBarTitle,
    ),
    super.backgroundColor = Colors.white,
    super.centerTitle = true,
    super.elevation = 0.5,
    super.iconTheme = const IconThemeData(color: Colors.black),
  });
}
