import 'package:flutter/material.dart';
import 'package:project_bansos/components/auth_textfield.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
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
              ThemeSwitch(),
              const Text(
                "REGISTER",
                style: TextStyle(fontSize: 30),
              ),
              AuthTextfield(
                errorText: Provider.of<RegisterProvider>(context).emailError,
                prefixIcon: Icon(Icons.alternate_email),
                labelText: "EMAIL",
                helperText: "Isi email Anda",
                controller: emailController,
              ),
              AuthTextfield(
                errorText: Provider.of<RegisterProvider>(context).passwordError,
                prefixIcon: Icon(Icons.lock),
                labelText: "PASSWORD",
                helperText: "Isi password Anda",
                obsecureText: true,
                controller: passwordController,
              ),
              AuthTextfield(
                errorText:
                    Provider.of<RegisterProvider>(context).confirmPasswordError,
                prefixIcon: Icon(Icons.lock),
                labelText: "KONFIRMASI PASSWORD",
                helperText: "Konfirmasi password Anda",
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
                  onPressed: register,
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
      ),
    );
  }
}
