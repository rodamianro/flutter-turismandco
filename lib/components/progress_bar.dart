import "package:flutter/material.dart";

class DefaultProgressBar extends LinearProgressIndicator {
  const DefaultProgressBar({
    super.key,
    super.backgroundColor = Colors.white,
    super.valueColor = const AlwaysStoppedAnimation<Color>(Colors.grey),
  });
}
