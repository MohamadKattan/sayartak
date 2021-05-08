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
        onSelectNotification: doSelectNotification);
    notifyListeners();
  }

  Future<void> doSelectNotification(String payload) async {}

  Future<void> firstNotifications() async {
    var android = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        priority: Priority.high, playSound: true);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(0, "Welcome with sayartak",
        "with us will find Waht do you need", platform,
        payload: "enjoy");
    notifyListeners();
  }

  Future<void> weeklyNotifications() async {
    var android = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        priority: Priority.high, playSound: true);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        "Welcome with sayartak",
        "with us will find Waht do you need",
        Day(1),
        Time(16, 10, 05),
        platform,
        payload: "enjoy");
    notifyListeners();
  }
}
