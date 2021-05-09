import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String title;
  String body;
  Timestamp timestamp;
  NotificationModel({this.title, this.body, this.timestamp});

  NotificationModel.fromMap(Map<String, dynamic> map) {
    title = map["title"];
    body = map["body"];
    timestamp = map["timestamp"];
  }
}
