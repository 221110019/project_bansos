import 'package:flutter/material.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    super.key,
  });

  @override
  Switch build(BuildContext context) {
    final themeProvider = ShortcutHelper.temaTerang(context);
    return Switch(
        value: themeProvider.terang,
        onChanged: (value) {
          themeProvider.toggleTema();
          ShortcutHelper.kataSistem(context,
              "${CakapHelper.tulisan(context)!.theme_1} ${themeProvider.terang ? CakapHelper.tulisan(context)!.theme_2 : CakapHelper.tulisan(context)!.theme_3}");
        },
        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
          (Set<WidgetState> states) {
            if (!themeProvider.terang) {
              return const Icon(Icons.dark_mode);
            } else {
              return const Icon(
                Icons.light_mode,
              );
            }
          },
        ));
  }
}
