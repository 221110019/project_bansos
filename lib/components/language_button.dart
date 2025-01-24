import 'package:flutter/material.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeProvider>().gantiBahasa();
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        borderOnForeground: true,
        color: Colors.black,
        elevation: 1,
        child: CircleAvatar(
          onBackgroundImageError: (exception, stackTrace) => Text(
              context.watch<ThemeProvider>().bahasaNow == 'id' ? 'id' : 'en'),
          backgroundImage: AssetImage(
              'assets/pictures/ben${context.watch<ThemeProvider>().bahasaNow == 'id' ? 'id' : 'en'}.png'),
        ),
      ),
    );
  }
}
