import 'package:flutter/material.dart';

class Styles {
  static const String _fontNameDefault = 'Muli';
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 16.0;
  static const _textSizeSmall = 12.0;
  static const double horizontalPaddingDefault = 12.0;
  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('000000');
  static final Color _textColorFaint = _hexToColor('999999');
  static final Color textColorBright = _hexToColor('FFFFFF');
  static final Color accentColor = _hexToColor('FF0000');

  static final locationTileCaption = TextStyle(
    fontFamily: _fontNameDefault,
    color: _textColorFaint,
    fontSize: _textSizeSmall,
  );

  static final locationTileSubtitle = TextStyle(
    fontFamily: _fontNameDefault,
    color: accentColor,
    fontSize: _textSizeDefault,
  );

  static final locationTileTitleDark = TextStyle(
    fontFamily: _fontNameDefault,
    color: textColorBright,
    fontSize: _textSizeLarge,
  );

  static final locationTileTitleLight = TextStyle(
    fontFamily: _fontNameDefault,
    color: _textColorStrong,
    fontSize: _textSizeLarge,
  );

  static final headerLarge = TextStyle(
    fontSize: _textSizeLarge,
    color: _textColorStrong,
    fontFamily: _fontNameDefault,
  );

  static final textDefault = TextStyle(
    fontSize: _textSizeDefault,
    color: _textColorDefault,
    fontFamily: _fontNameDefault,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static const navBarTitle = TextStyle(
    fontFamily: _fontNameDefault,
  );
}
