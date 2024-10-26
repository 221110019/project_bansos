import 'package:flutter/material.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/pages/auth/login_screen.dart';
import 'package:project_bansos/pages/auth/register_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ThemeSwitch(),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SELAMAT DATANG di TOKO ASAN",
                  style: TextStyle(fontSize: 45),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Apakah Anda sudah punya akun?",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TombolCustom(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SUDAH"),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(Icons.login),
                        Text("Login sekarang"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TombolCustom(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ));
                    },
                    filled: false,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("BELUM"),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(Icons.app_registration),
                        Text("Daftar akun"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
