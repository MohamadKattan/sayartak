import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyCars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(AppLocalizations.of(context).mycar),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: saleCarReference
            .where("postId", isEqualTo: "${currentUser.uid}")
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
    AsyncSnapshot<QuerySnapshot> snapshot,
    int index,
  ) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.0, left: 4.0),
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
                                "${AppLocalizations.of(context).brand} : ${saleCar.brand} ${saleCar.model}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                          Text("${AppLocalizations.of(context).city} : ${saleCar.city}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16.0)),
                          Text("${AppLocalizations.of(context).km} : ${saleCar.km}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16.0)),
                          Text("${AppLocalizations.of(context).price} :\$ ${saleCar.price}",
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
                    padding: EdgeInsets.only(right: 4.0, left: 4.0),
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                saleCarReference
                                    .doc(snapshot.data.docs[index].id)
                                    .delete();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    )))
          ],
        ),
      ],
    );
  }
}
