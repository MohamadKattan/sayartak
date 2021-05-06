import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/car_details.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/new_gallery.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:sayartak/service/call_message_service.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryNo7 extends StatelessWidget {
  final Gallery stamp;
  GalleryNo7({this.stamp});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight + 20),
              child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(stamp.image)),
                      Column(children: [
                        Text(stamp.name,style:TextStyle(color:Colors.white,fontSize: 18)),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => CallService.launchCallGallery(context, stamp),
                              icon: Icon(Icons.call,
                                  color: Colors.green),
                            ),
                            IconButton(
                              onPressed: () => CallService.launchLocationGallery(context, stamp),
                              icon: Icon(Icons.add_location_alt,
                                  color: Colors.red),
                            ),
                          ],
                        )
                      ]),
                    ],
                  )))),
      body: StreamBuilder<QuerySnapshot>(
        stream:
        adminAddCarReference.where("statusCar", isEqualTo: "7").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Waiting..."));
          } else if (snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var car = SaleCar.fromMap(snapshot.data.docs[index].data());
                  return listOfcars(car, context, snapshot, index);
                });
          } else {
            return Center(child: Text("No data yet..."));
          }
        },
      ),
    );
  }

  Widget listOfcars(SaleCar car, BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.0, left: 4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarDetails(
                            saleCarDetails: car,
                            idLike: snapshot.data.docs[index].id,
                            // idLike: id,
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
                                      image: car.image)),
                            ),
                            Text(car.brand.toString()),
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
                              child: Text("Model : ${car.brand} ${car.model}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0)),
                            ),
                            Text("City : ${car.gaz}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16.0)),
                            Text("Km : ${car.km}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16.0)),
                          ],
                        ),
                      ],
                    )),
              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "\$ ${car.price}",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )))
          ],
        ),
      ],
    );
  }
}