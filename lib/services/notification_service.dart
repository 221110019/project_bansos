// ignore_for_file: use_build_context_synchronously
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/helper/exp_stok_helper.dart';

class NotificationService {
  late BuildContext context;
  NotificationService(this.context);

  Future<void> createWelcomeNotification() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications()
            .requestPermissionToSendNotifications()
            .then((value) => Navigator.pop(context));
      }
    });
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Timestamp.now().nanoseconds,
          channelKey: 'welcome',
          title: 'Selamat datang di TOKO ASAN',
          body: 'Silahkan login atau mendaftar akun baru.'),
    );
  }

  Future<void> createLoginNotification() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications()
            .requestPermissionToSendNotifications()
            .then((value) => Navigator.pop(context));
      }
    });
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Timestamp.now().nanoseconds,
          channelKey: 'log_in',
          title: 'Anda melakukan login pada ${IndomieHelper.sekarang()}?',
          body: 'Jika iya, maka silahkan abaikan pesan ini.'),
    );
  }

  Future<void> createLogoutNotification() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications()
            .requestPermissionToSendNotifications()
            .then((value) => Navigator.pop(context));
      }
    });
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Timestamp.now().nanoseconds,
          channelKey: 'log_out',
          title: 'SAMPAI JUMPA',
          body: 'Anda telah melakukan logout pada ${IndomieHelper.sekarang()}'),
    );
  }
}
