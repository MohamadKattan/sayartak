import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/all_screens/favorite_screen.dart';
import 'package:sayartak/all_screens/login_screen.dart';
import 'package:sayartak/all_screens/my_car.dart';
import 'package:sayartak/all_screens/notifications_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sayartak/provider/notifiction_provider.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;
  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notifictionIndex = Provider.of<NotifictionIndex>(context).index;
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
                    Text(AppLocalizations.of(context).welcome,
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      currentUser.displayName != null
                          ? "${currentUser.displayName}"
                          : "${currentUser.email}",
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    )
                  ],
                ),
              )),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
            leading: notifictionIndex!=null?Icon(Icons.notifications_rounded,color: Colors.red,):Icon(Icons.notifications_rounded,color: Colors.grey,),
            title: Text(AppLocalizations.of(context).notification),
            subtitle: notifictionIndex!=null?Text("$notifictionIndex"):Text(""),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
            leading: Icon(Icons.favorite),
            title: Text(AppLocalizations.of(context).favoritecar),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyCars())),
            leading: Icon(Icons.auto_awesome_motion),
            title: Text(AppLocalizations.of(context).mycar),
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
            title: Text(AppLocalizations.of(context).logout),
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
