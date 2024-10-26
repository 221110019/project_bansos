import 'package:flutter/material.dart';
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
        onChanged: (value) => themeProvider.toggleTema(),
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
