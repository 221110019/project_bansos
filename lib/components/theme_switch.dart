import 'package:flutter/material.dart';
import 'package:project_bansos/provider/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    super.key,
    required this.themeProvider,
  });

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    // Color primer = Theme.of(context).colorScheme.surface;
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
