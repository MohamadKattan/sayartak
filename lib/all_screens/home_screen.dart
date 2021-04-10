import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/main_screen.dart';
import 'package:sayartak/widget/customDrawer.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
class HomeScreen extends StatefulWidget {
  static const String screenId = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FSBStatus drawerStatus;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("sayartak"),
          centerTitle: false,
          backgroundColor: Colors.black,
          leading: IconButton(
            color: Colors.redAccent[700],
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            },
          ),
        ),
        body: FoldableSidebarBuilder(
          drawerBackgroundColor: Colors.grey[700],
          status: drawerStatus,
          screenContents: MainScreen(),
          drawer: CustomDrawer(
            closeDrawer: () {
              setState(() {
                drawerStatus = FSBStatus.FSB_CLOSE;
              });
            },
          ),
        ),
      ),
    );
  }
}
