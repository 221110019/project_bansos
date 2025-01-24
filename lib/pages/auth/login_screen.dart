import 'package:flutter/material.dart';
import 'package:project_bansos/components/auth_textfield.dart';
import 'package:project_bansos/components/language_button.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/provider/login_provider.dart';
import 'package:project_bansos/services/auth_services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({super.key, required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthServices authServices = AuthServices();
  void login() {
    Provider.of<LoginProvider>(context, listen: false).resetError();
    FocusScope.of(context).unfocus();
    authServices.loginUser(
        emailController.text, passwordController.text, context);
    ShortcutHelper.notifWoe(context).createLoginNotification();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              Text(
                CakapHelper.tulisan(context)!.login_1,
                style: const TextStyle(fontSize: 30),
              ),
              AuthTextfield(
                  errorText: Provider.of<LoginProvider>(context).emailError,
                  controller: emailController,
                  prefixIcon: const Icon(Icons.alternate_email),
                  labelText: "EMAIL",
                  helperText: CakapHelper.tulisan(context)!.login_2),
              AuthTextfield(
                errorText: Provider.of<LoginProvider>(context).passwordError,
                controller: passwordController,
                prefixIcon: const Icon(Icons.lock),
                labelText: "PASSWORD",
                helperText: CakapHelper.tulisan(context)!.login_3,
                obsecureText: true,
              ),
              TextButton(
                  onPressed: () {
                    widget.showRegisterPage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        CakapHelper.tulisan(context)!.login_4,
                        style: TextStyle(
                          color: ShortcutHelper.warnaOnSurface(context),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(CakapHelper.tulisan(context)!.login_5),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              TombolCustom(
                  onPressed: login,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.login),
                      Text(CakapHelper.tulisan(context)!.login_1),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
