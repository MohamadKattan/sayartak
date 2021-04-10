import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:transparent_image/transparent_image.dart';

class NewCarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference car = FirebaseFirestore.instance.collection('saleCar');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("UsedCar"),
          centerTitle: false,
          actions: [
            IconButton(onPressed:()=>print("searchBUTTON"),icon:Icon(Icons.search) )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: car.snapshots(includeMetadataChanges: true),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomCircular();
              }
              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  SaleCar saleCar = SaleCar.fromMap(document.data());
                  return carList(context, saleCar);
                }).toList(),
              );
            }));
  }

// for show list of car from stream =>fireStore
  Widget carList(BuildContext context, SaleCar saleCar) {
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
                                height: MediaQuery.of(context).size.height * 15 / 100,
                                width: MediaQuery.of(context).size.width * 30 / 100,
                                child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                    placeholder: kTransparentImage,
                                    image: saleCar.image)),

                          ),
                          Text("10/4/2021"),
                          Row(children: [Icon(Icons.directions_car),Icon(Icons.ac_unit),Icon(Icons.add_location_rounded)],)
                        ],
                      ),
                      SizedBox(width: 6.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(4.0),
                            child: Text("Model : ${saleCar.brand} ${saleCar.model}",style:TextStyle(color: Colors.black,fontSize: 18.0)),
                          ),
                          Text("City : ${saleCar.city}",style:TextStyle(color: Colors.grey,fontSize: 16.0)),
                          Text("Km : ${saleCar.km}",style:TextStyle(color: Colors.grey,fontSize: 16.0)),



                        ],
                      ),
                    ],
                  )),
            ),
            Positioned(bottom: 0.0,right: 0.0,left: 0.0,child: Padding(
              padding: EdgeInsets.only(right:4.0,left: 4.0),
              child: Container(height: 40.0, decoration: BoxDecoration(
                color: Colors.black87,
              borderRadius:BorderRadius.all(Radius.circular(6.0))),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.phone,color:Colors.green),SizedBox(width: 8.0),Icon(Icons.favorite,color:Colors.white)
                      ],),
                      Text("\$ ${saleCar.price}",style: TextStyle(fontSize: 16.0,color: Colors.white),)
                    ],
                  ),
                ),
            )))
          ],
        ),
      ],
    );
  }
}
