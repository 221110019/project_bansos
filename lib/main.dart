import 'package:flutter/material.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          )
        ],
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
              title: 'TOKO ASAN',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: "RobotoCondensed",
                colorScheme:
                    Provider.of<ThemeProvider>(context, listen: false).terang
                        ? const ColorScheme.light(
                            primary: Color.fromRGBO(200, 0, 0, 1),
                            secondary: Color.fromRGBO(100, 0, 0, 1),
                          )
                        : const ColorScheme.dark(
                            primary: Color.fromRGBO(200, 1, 1, 1),
                          ),
                useMaterial3: true,
              ),
              home: const Starter());
        }));
  }
}

class Starter extends StatelessWidget {
  const Starter({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGO"),
        actions: [ThemeSwitch(themeProvider: themeProvider)],
      ),
      body: Center(
        child: Text("${themeProvider.terang ? "LIGHT" : "DARK"} MODE"),
      ),
    );
  }
}
