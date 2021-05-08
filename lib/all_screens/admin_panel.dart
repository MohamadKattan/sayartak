import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/all_screens/admin_add_car.dart';
import 'package:sayartak/all_screens/admin_add_gallery.dart';
import 'package:sayartak/all_screens/admin_gallery_screen.dart';
import 'package:sayartak/all_screens/login_screen.dart';
import 'package:sayartak/service/locale_notficition.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false),
        ),
        title: Text("Admin panel"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddGalleryScreen())),
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width * 80 / 100,
                height: MediaQuery.of(context).size.height * 10 / 100,
                child: Center(
                    child: Text(
                  "Add new gallery",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminGalleryScreen())),
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width * 80 / 100,
                height: MediaQuery.of(context).size.height * 10 / 100,
                child: Center(
                    child: Text(
                  " galleries",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminAddCAR())),
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width * 80 / 100,
                height: MediaQuery.of(context).size.height * 10 / 100,
                child: Center(
                    child: Text(
                  "add a car for gallery",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
          Center(
            child: Consumer<LocaleNotifications>(
              builder: (context, model, _) => TextButton(
                onPressed: () => model.firstNotifications(),
                child: Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 80 / 100,
                  height: MediaQuery.of(context).size.height * 10 / 100,
                  child: Center(
                      child: Text(
                    "firstNotifications",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
