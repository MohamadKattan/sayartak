import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/add_car_screen.dart';
import 'package:sayartak/all_screens/new_car_screen.dart';
import 'package:sayartak/all_screens/used_car.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(6.0),
          child: ListView(
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
                          height: MediaQuery.of(context).size.height * 20 / 100,
                          width: MediaQuery.of(context).size.width * 30 / 100,
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
                                Image.asset("images/add.png", height: 50),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Sale a car",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )
                              ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NewCarScreen();
                          }));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 20 / 100,
                          width: MediaQuery.of(context).size.width * 30 / 100,
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
                                Image.asset("images/newcar.png", height: 50),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "New car",
                                  style: TextStyle(
                                      fontSize: 16.0,
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
                          height: MediaQuery.of(context).size.height * 20 / 100,
                          width: MediaQuery.of(context).size.width * 30 / 100,
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
                                Image.asset("images/usedcar.png", height: 50),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Used car",
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
                      Container(
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        width: MediaQuery.of(context).size.width * 30 / 100,
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
                              Image.asset("images/import.png", height: 30),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "importing cars",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        width: MediaQuery.of(context).size.width * 30 / 100,
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
                              Image.asset("images/carsshop.png", height: 30),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Gallery's",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        width: MediaQuery.of(context).size.width * 30 / 100,
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
                              Image.asset("images/pinkcoins.png", height: 30),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Prices",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
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
                      Container(
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        width: MediaQuery.of(context).size.width * 30 / 100,
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
                              Image.asset("images/carfix.png", height: 30),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "risque",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        width: MediaQuery.of(context).size.width * 30 / 100,
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
                                  height: 30),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "notification",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        width: MediaQuery.of(context).size.width * 30 / 100,
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
                              Image.asset("images/owtruck.png", height: 30),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "towTruck",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
