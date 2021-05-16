import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/notification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text(AppLocalizations.of(context).notification),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: adminNotificationReference
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data.docs.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications_off_rounded,color: Colors.red[700],size: 60,),
              Center(child: Text("No data yet")),
            ],
          );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Some thing went wrong"));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              NotificationModel noty =
              NotificationModel.fromMap(snapshot.data.docs[index].data());
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("images/splash.png")),
                      title: Text(noty.title,
                          style:
                          TextStyle(color: Colors.black, fontSize: 16.0)),
                      subtitle: Text(noty.body,
                          style: TextStyle(color: Colors.blueGrey)),
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
        },
      ),
    );
  }
}
