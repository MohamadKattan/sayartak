import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sayartak/all_screens/login_screen.dart';
import 'package:sayartak/all_screens/my_car.dart';
import 'package:sayartak/all_screens/profile_screen.dart';
import 'package:sayartak/confige.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;
  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(
                          "images/splash.png",
                        )),
                    Text("Welcome :",
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      currentUser.displayName!=null?
                      "${currentUser.displayName}":"${currentUser.email}",
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    )
                  ],
                ),
              )),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
              closeDrawer();
            },
            leading: Icon(Icons.person),
            title: Text(
              "Your Profile",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");
            },
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Payments");
            },
            leading: Icon(Icons.payment),
            title: Text("Payments"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyCars())),
            leading: Icon(Icons.auto_awesome_motion),
            title: Text("My cars"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              singOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
          ),
        ],
      ),
    );
  }

  Future<void> singOut() async {
    try {
      await auth.signOut();
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
    } catch (ex) {
      print("errorGoogleSingOut::" + ex.toString());
    }
  }
}
