import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/cars_gallery_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/new_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GalleriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).gallery),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: newGalleryReference.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("error"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          } else if (snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
              itemBuilder: (_, index) {
                var gallery = Gallery.fromMap(snapshot.data.docs[index].data());
                return listGalleries(context, index, gallery, snapshot);
              },
              itemCount: snapshot.data.docs.length,
            );
          } else {
            return Text("Wait....");
          }
        },
      ),
    );
  }

  Widget listGalleries(BuildContext context, int index, Gallery gallery,
      AsyncSnapshot<QuerySnapshot> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CarsGalleryScreen(stamp: gallery))),
        child: Container(
          height: MediaQuery.of(context).size.height * 20 / 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 4.0,
                    spreadRadius: 0.2,
                    offset: Offset(0.7, 0.7))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Container(
                      height: 60,
                      width: 80,
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage, image: gallery.image),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black12,
                      height: MediaQuery.of(context).size.height,
                      width: 2,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(gallery.name,
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                      Text("Address : ${gallery.address1}",
                          style: TextStyle(fontSize: 20.0, color: Colors.red)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
