import 'package:flutter/material.dart';
import 'package:project_bansos/components/auth_textfield.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/pages/auth/register_screen.dart';
import 'package:project_bansos/pages/customer/home_cust.dart';
import 'package:project_bansos/pages/owner/home/home_owner.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              "LOGIN",
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
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Belum punya akun?",
                      style: TextStyle(
                        color: ShortcutHelper.warnaOnSurface(context),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text("Register"),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            TombolCustom(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeOwner(),
                  ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
                    Text("LOGIN"),
                  ],
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeCust()));
                },
                child: Text('Home Page Customer'))
          ],
        ),
      ),
    );
  }
}
