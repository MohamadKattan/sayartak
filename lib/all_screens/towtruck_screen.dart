import 'package:flutter/material.dart';
import 'package:sayartak/confige.dart';

class TowTruckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tow truck"),
        centerTitle: false,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircleAvatar(radius: 25,child: Image.asset("images/fix1.png")),
                Text("Sayartak",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                Text("Revolutions roadside assistance",style: TextStyle(color: Colors.grey))
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Text("Risque serves on road 24/24 in Turkey wide"),
                SizedBox(height: 10),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Image.asset("images/Untitled3.png"),
                  ),
                  Text("Risque truck")

                ]),
                SizedBox(height: 10),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Image.asset("images/Untitled2.png"),
                  ),
                  Text("Fix wheel"),

                ]),
                SizedBox(height: 10),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircleAvatar(radius:20 ,child: Container(child: Image.asset("images/Untitled1.png"))),
                  ),
                  Text("Fix wheel"),

                ]),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height*15/100,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.5,
                      spreadRadius: 8.0,
                      offset: Offset(0.7,0.7)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
