import 'package:flutter/material.dart';
import 'package:project_bansos/components/auth_textfield.dart';
import 'package:project_bansos/components/language_button.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/provider/register_provider.dart';
import 'package:project_bansos/services/auth_services.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({super.key, required this.showLoginPage});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthServices authServices = AuthServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() {
    setState(() {
      FocusScope.of(context).unfocus();
      Provider.of<RegisterProvider>(context, listen: false).resetError();
      authServices.registerErrorValidate(emailController.text,
          passwordController.text, confirmPasswordController.text, context);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                CakapHelper.tulisan(context)!.login_5,
                style: const TextStyle(fontSize: 30),
              ),
              AuthTextfield(
                errorText: Provider.of<RegisterProvider>(context).emailError,
                prefixIcon: const Icon(Icons.alternate_email),
                labelText: "EMAIL",
                helperText: CakapHelper.tulisan(context)!.login_2,
                controller: emailController,
              ),
              AuthTextfield(
                errorText: Provider.of<RegisterProvider>(context).passwordError,
                prefixIcon: const Icon(Icons.lock),
                labelText: "PASSWORD",
                helperText: CakapHelper.tulisan(context)!.login_3,
                obsecureText: true,
                controller: passwordController,
              ),
              AuthTextfield(
                errorText:
                    Provider.of<RegisterProvider>(context).confirmPasswordError,
                prefixIcon: const Icon(Icons.lock),
                labelText: CakapHelper.tulisan(context)!.reg_1,
                helperText: CakapHelper.tulisan(context)!.reg_2,
                obsecureText: true,
                controller: confirmPasswordController,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.showLoginPage();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        CakapHelper.tulisan(context)!.reg_3,
                        style: TextStyle(
                          color: ShortcutHelper.warnaOnSurface(context),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(CakapHelper.tulisan(context)!.reg_4),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              TombolCustom(
                  onPressed: register,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.login),
                      Text(CakapHelper.tulisan(context)!.intro_6.toUpperCase()),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
