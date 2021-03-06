import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/add_car_screen.dart';
import 'package:sayartak/all_screens/galleries_screen.dart';
import 'package:sayartak/all_screens/new_car_screen.dart';
import 'package:sayartak/all_screens/notifications_screen.dart';
import 'package:sayartak/all_screens/towtruck_screen.dart';
import 'package:sayartak/all_screens/used_car.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sayartak/widget/customDrawer.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).title),
          centerTitle: false,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.all(2.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 25 / 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddScreen()));
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 16.0,
                                      spreadRadius: 0.6,
                                      offset: Offset(0.7, 0.7))
                                ],
                                color: Colors.white),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/add.png", height: 45),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(context).salecar,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GalleriesScreen())),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 16.0,
                                      spreadRadius: 0.6,
                                      offset: Offset(0.7, 0.7))
                                ],
                                color: Colors.white),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/carsshop.png",
                                      height: 50),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).gallery,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 25 / 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewCarScreen();
                            }));
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 16.0,
                                      spreadRadius: 0.6,
                                      offset: Offset(0.7, 0.7))
                                ],
                                color: Colors.white),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/newcar.png", height: 45),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).newcar,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UsedCarScreen();
                            }));
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 16.0,
                                      spreadRadius: 0.6,
                                      offset: Offset(0.7, 0.7))
                                ],
                                color: Colors.white),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/usedcar.png", height: 40),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(context).usedcar,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 25 / 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen())),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 16.0,
                                      spreadRadius: 0.6,
                                      offset: Offset(0.7, 0.7))
                                ],
                                color: Colors.white),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/notification-01.png",
                                      height: 50),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).notification,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TowTruckScreen())),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 20 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 16.0,
                                      spreadRadius: 0.6,
                                      offset: Offset(0.7, 0.7))
                                ],
                                color: Colors.white),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/owtruck.png", height: 50),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).towtruck,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 10 / 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 16.0,
                                spreadRadius: 0.6,
                                offset: Offset(0.7, 0.7))
                          ],
                          color: Colors.white),
                      child: Carousel(
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1500),
                        dotSize: 6.0,
                        dotIncreasedColor: Color(0xFFFF335C),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.topRight,
                        dotVerticalPadding: 10.0,
                        showIndicator: false,
                        indicatorBgPadding: 7.0,
                        images: [
                          ExactAssetImage("images/splash.png"),
                          ExactAssetImage("images/2.jpg"),
                          ExactAssetImage("images/4.jpg"),
                          ExactAssetImage("images/6.jpg"),
                          ExactAssetImage("images/7.jpg"),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
