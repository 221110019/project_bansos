import 'package:flutter/material.dart';

class ShortcutHelper {
  static Color warnaSurface(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color warnaOnSurface(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  static Color warnaPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color warnaOnPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }
}
