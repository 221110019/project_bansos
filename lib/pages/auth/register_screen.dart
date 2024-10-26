import 'package:flutter/material.dart';
import 'package:project_bansos/components/auth_textfield.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/pages/auth/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
            ThemeSwitch(), //hapus kalau tak perlu
            const Text(
              "REGISTER",
              style: TextStyle(fontSize: 30),
            ),
            const AuthTextfield(
                prefixIcon: Icon(Icons.alternate_email),
                labelText: "USERNAME",
                helperText: "Isi username Anda"),
            const AuthTextfield(
              prefixIcon: Icon(Icons.lock),
              labelText: "PASSWORD",
              helperText: "Isi password Anda",
              obsecureText: true,
            ),
            const AuthTextfield(
              prefixIcon: Icon(Icons.lock),
              labelText: "KONFIRMASI PASSWORD",
              helperText: "Konfirmasi password Anda",
              obsecureText: true,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Sudah punya akun?",
                      style: TextStyle(
                        color: ShortcutHelper.warnaOnSurface(context),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text("Login"),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            TombolCustom(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
                    Text("DAFTAR AKUN"),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
