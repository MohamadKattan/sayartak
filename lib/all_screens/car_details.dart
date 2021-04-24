
import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/full_image.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:transparent_image/transparent_image.dart';

class CarDetails extends StatelessWidget {
  final SaleCar saleCarDetails;
  CarDetails({this.saleCarDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Car details"),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () => print("call")),
          IconButton(
              icon: Icon(Icons.favorite), onPressed: () => print("favorite")),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullImage(
                              image: saleCarDetails.image,
                            )));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 40 / 100,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                    tag: "someTag",
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: saleCarDetails.image,
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${saleCarDetails.brand} ${saleCarDetails.model}",
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "USD : ${saleCarDetails.price}",
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                "${saleCarDetails.installment}",
                style: TextStyle(fontSize: 16.0),
              ),
            ]),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Not :  ${saleCarDetails.not}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("City :", style: TextStyle(fontSize: 16.0)),
                Text(" ${saleCarDetails.city}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("k.m :", style: TextStyle(fontSize: 16.0)),
                Text(" ${saleCarDetails.km}", style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gear:", style: TextStyle(fontSize: 16.0)),
                Text(" ${saleCarDetails.gear}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gaz:", style: TextStyle(fontSize: 16.0)),
                Text("${saleCarDetails.gaz}", style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Brand:", style: TextStyle(fontSize: 16.0)),
                Text("${saleCarDetails.brand}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Model:", style: TextStyle(fontSize: 16.0)),
                Text(" ${saleCarDetails.model}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price:", style: TextStyle(fontSize: 16.0)),
                Text("\$ ${saleCarDetails.price}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status car:", style: TextStyle(fontSize: 16.0)),
                Text(" ${saleCarDetails.statusCar}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
