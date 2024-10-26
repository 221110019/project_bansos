import 'package:flutter/material.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ShortcutHelper {
  static Color warnaSurface(BuildContext context) {
    return Theme.of(context).colorScheme.surface; //hitam:putih
  }

  static Color warnaOnSurface(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface; //putih:hitam
  }

  static Color warnaPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.primary; //merah:merah
  }

  static Color warnaOnPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary; //hitam:putih
  }

  static ThemeProvider temaTerang(BuildContext context) {
    return Provider.of<ThemeProvider>(context);
  }
}
