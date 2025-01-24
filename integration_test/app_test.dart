import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project_bansos/components/language_button.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/pages/auth/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:project_bansos/main.dart';
import 'package:project_bansos/provider/auth_provider.dart';
import 'package:project_bansos/provider/theme_provider.dart';

// flutter test integration_test/app_test.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Halaman Intro untuk setiap user yang tidak/belum terdaftar',
      (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(IntroScreen), findsOneWidget);
    expect(find.byType(LanguageButton), findsOneWidget);
    expect(find.byType(ThemeSwitch), findsOneWidget);
  });
}
