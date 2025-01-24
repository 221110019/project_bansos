// ignore_for_file: use_build_context_synchronously
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/exp_stok_helper.dart';

class NotificationService {
  late BuildContext context;
  NotificationService(this.context);

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
          title:
              '${CakapHelper.tulisan(context)!.notif_1} ${IndomieHelper.sekarang()}?',
          body: CakapHelper.tulisan(context)!.notif_2),
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
          title: CakapHelper.tulisan(context)!.notif_3,
          body:
              '${CakapHelper.tulisan(context)!.notif_4} ${IndomieHelper.sekarang()}'),
    );
  }
}
