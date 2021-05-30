import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/notification.dart';


class AdminNotControl extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text("AdminNotControl"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: adminNotificationReference
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data.docs == null) {
            return Center(child: Text("No data yet"));
          } else if (snapshot.hasError) {
            return Center(child: Text("some thing went wrong"));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                NotificationModel noty =
                    NotificationModel.fromMap(snapshot.data.docs[index].data());
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onDoubleTap: () => adminNotificationReference
                            .doc(snapshot.data.docs[index].id)
                            .delete(),
                        child: Container(
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("images/splash.png")),
                            title: Text(noty.title,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                            subtitle: Text(noty.body,
                                style: TextStyle(color: Colors.blueGrey)),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      )
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.docs.length,
            );
          }
        },
      ),
    );
  }
}
