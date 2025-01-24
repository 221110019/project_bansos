import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_bansos/pages/auth/auth_state.dart';
import 'package:project_bansos/provider/auth_provider.dart';
import 'package:project_bansos/provider/filter_stock_provider.dart';
import 'package:project_bansos/provider/login_provider.dart';
import 'package:project_bansos/provider/register_provider.dart';
import 'package:project_bansos/services/shared_preferences.dart';
import 'package:project_bansos/pages/auth/intro_screen.dart';
import 'package:project_bansos/provider/owner_bottom_nav_provider.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize('resource://drawable/launch_background', [
    NotificationChannel(
        channelKey: 'log_in',
        channelName: 'Log In',
        importance: NotificationImportance.High,
        channelDescription: 'Login confirmation for account protection'),
    NotificationChannel(
        channelKey: 'log_out',
        channelName: 'Log Out',
        channelDescription: 'Log Out'),
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferencesServices sharedPreferencesHelper =
        SharedPreferencesServices();
    await sharedPreferencesHelper.loadData(context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RegisterProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => OwnerMetaProvider(),
          ),
          ChangeNotifierProvider(create: (context) => FilterStockProvider())
        ],
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(context.watch<ThemeProvider>().bahasaNow),
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
                            secondary: Color.fromRGBO(100, 0, 0, 1),
                            shadow: Colors.white,
                          ),
                useMaterial3: true,
              ),
              home: Provider.of<AuthProvider>(context).firstTime
                  ? const IntroScreen()
                  : const AuthState(showLoginPage: true));
        }));
  }
}
