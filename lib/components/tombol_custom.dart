import 'package:flutter/material.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';

class TombolCustom extends StatelessWidget {
  final void Function()? onPressed;

  final Widget child;

  final bool filled;

  const TombolCustom(
      {super.key,
      required this.onPressed,
      required this.child,
      this.filled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: filled
              ? ShortcutHelper.warnaOnPrimary(context)
              : ShortcutHelper.warnaPrimary(context),
          backgroundColor: filled
              ? ShortcutHelper.warnaPrimary(context)
              : ShortcutHelper.warnaOnPrimary(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                color: filled
                    ? ShortcutHelper.warnaOnPrimary(context)
                    : ShortcutHelper.warnaPrimary(context),
              )),
        ),
        child: child);
  }
}
