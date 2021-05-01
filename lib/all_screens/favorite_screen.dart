import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/full_image.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Favorite"),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: favoriteCarReference
            .where("postLiked", isEqualTo: "${currentUser.uid}")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.clear,
                  size: 40,
                  color: Colors.redAccent[700],
                ),
                Text('Something went wrong'),
              ],
            );
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return CustomCircular();
          }
          if (snapshots.connectionState == ConnectionState.active) {
            return ListView.builder(
              itemCount: snapshots.data.docs.length,
              itemBuilder: (context, index) {
                SaleCar saleCar =
                    SaleCar.fromMap(snapshots.data.docs[index].data());
                return carList(context, saleCar, snapshots, index);
              },
            );
          }
          if (snapshots == null) {
            return Center(child: Text("No data yet!!"));
          } else {
            return Text("error");
          }
        },
      ),
    );
  }

// for show list of car from stream =>fireStore
  Widget carList(
    BuildContext context,
    SaleCar saleCar,
    snapshot,
    int i,
  ) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        Stack(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullImage(
                              image: saleCar.image,
                            )));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 30 / 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 6.0,
                            spreadRadius: 0.4,
                            offset: Offset(0.2, 0.4))
                      ],
                      color: Colors.white),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                height: MediaQuery.of(context).size.height *
                                    15 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    30 /
                                    100,
                                child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: kTransparentImage,
                                    image: saleCar.image)),
                          ),
                          Text(saleCar.statusCar.toString()),
                          Row(
                            children: [
                              Icon(Icons.directions_car),
                              Icon(Icons.ac_unit),
                              Icon(Icons.add_location_rounded)
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                                "Model : ${saleCar.brand} ${saleCar.model}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                          Text("City : ${saleCar.city}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16.0)),
                          Text("Km : ${saleCar.km}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16.0)),
                        ],
                      ),
                    ],
                  )),
            ),
            Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: Padding(
                    padding:
                        EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.phone, color: Colors.green)),
                          SizedBox(width: 14.0),
                          IconButton(
                              onPressed: () {
                                favoriteCarReference
                                    .doc(snapshot.data.docs[i].id)
                                    .delete();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )))
          ],
        ),
      ],
    );
  }
}
