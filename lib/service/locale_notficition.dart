import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocaleNotifications extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialization() async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings ios = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: android,
      iOS: ios,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    notifyListeners();
  }

  Future<void> selectNotification(String payload) async {}

  Future<void> firstNotifications(
      TextEditingController body, TextEditingController title) async {
    var android = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: false);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin
        .show(0, title.text, body.text, platform, payload: "enjoy");
    notifyListeners();
  }

  Future<void> publishDon () async {
    var android = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: false);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin
        .show(0, "Publish Success","We wish for you good deal", platform, payload: "enjoy");
    notifyListeners();
  }

  Future<void> timelyNotifications() async {
    var interval = RepeatInterval.daily;
    var android = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: false);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        "Welcome to sayartak",
        "with us will find  your car ",
        interval,
        platform,
        androidAllowWhileIdle: true);
    notifyListeners();
  }

  Future<void> cancelNotifications() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
