import 'package:flutter/material.dart';
import 'package:project_bansos/components/language_button.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/services/auth_services.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  AuthServices authServices = AuthServices();
  void logout() {
    authServices.logoutUser();
    ShortcutHelper.notifWoe(context).createLogoutNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CakapHelper.tulisan(context)!.cust_home),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                  title: Text(authServices.auth.currentUser!.email as String),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  CakapHelper.tulisan(context)!.cust_profile_1,
                  style: const TextStyle(fontSize: 15),
                ),
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: Text(CakapHelper.tulisan(context)!.cust_profile_2),
                  trailing: const ThemeSwitch(),
                ),
                ListTile(
                  leading: const Icon(Icons.translate),
                  title: Text(CakapHelper.tulisan(context)!.cust_profile_3),
                  trailing: const LanguageButton(),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ShortcutHelper.warnaPrimary(context)),
                  onPressed: logout,
                  child: Text(
                    CakapHelper.tulisan(context)!.o_dash_3,
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
