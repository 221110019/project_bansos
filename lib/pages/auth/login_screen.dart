import 'package:flutter/material.dart';
import 'package:project_bansos/components/auth_textfield.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
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
              ThemeSwitch(), //hapus kalau tak perlu
              const Text(
                "LOGIN",
                style: TextStyle(fontSize: 30),
              ),
              AuthTextfield(
                  errorText: Provider.of<LoginProvider>(context).emailError,
                  controller: emailController,
                  prefixIcon: Icon(Icons.alternate_email),
                  labelText: "EMAIL",
                  helperText: "Isi email Anda"),
              AuthTextfield(
                errorText: Provider.of<LoginProvider>(context).passwordError,
                controller: passwordController,
                prefixIcon: Icon(Icons.lock),
                labelText: "PASSWORD",
                helperText: "Isi password Anda",
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
                  onPressed: login,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login),
                      Text("LOGIN"),
                    ],
                  )),
              // TextButton(
              //     onPressed: () {
              //       Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) => HomeCust()));
              //     },
              //     child: Text('Home Page Customer'))
            ],
          ),
        ),
      ),
    );
  }
}
