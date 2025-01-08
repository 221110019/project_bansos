import 'package:flutter/material.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';

class AltGambarError extends StatelessWidget {
  const AltGambarError({
    super.key,
    required this.lebar,
    required this.tinggi,
  });

  final double lebar;
  final double tinggi;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: Container(
      height: tinggi,
      width: lebar,
      color: ShortcutHelper.warnaOnSurface(context),
      child: Center(
        child: Text(
          'TOKO\nASAN',
          style: TextStyle(
            color: ShortcutHelper.warnaPrimary(context),
          ),
        ),
      ),
    ));
  }
}
