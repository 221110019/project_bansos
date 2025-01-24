import 'package:flutter/material.dart';
import 'package:project_bansos/components/language_button.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/pages/auth/auth_state.dart';

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThemeSwitch(),
                LanguageButton(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  CakapHelper.tulisan(context)!.intro_1,
                  style: const TextStyle(fontSize: 45),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              CakapHelper.tulisan(context)!.intro_2,
              style: const TextStyle(fontSize: 25),
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AuthState(
                                showLoginPage: true,
                              )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(CakapHelper.tulisan(context)!.intro_3),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(Icons.login),
                        Text(CakapHelper.tulisan(context)!.intro_4),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TombolCustom(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AuthState(
                          showLoginPage: false,
                        ),
                      ));
                    },
                    filled: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(CakapHelper.tulisan(context)!.intro_5),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(Icons.app_registration),
                        Text(CakapHelper.tulisan(context)!.intro_6),
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
