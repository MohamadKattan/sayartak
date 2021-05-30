import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/all_screens/full_image.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/favorite_model.dart';
import 'package:sayartak/provider/like_provider.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(AppLocalizations.of(context).favoritecar),
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
                FavoriteModel favoriteModel =
                FavoriteModel.fromMap(snapshots.data.docs[index].data());
                return carList(context, favoriteModel, snapshots, index);
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
    FavoriteModel favoriteModel,
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
                              image: favoriteModel.image,
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
                                    image: favoriteModel.image)),
                          ),
                          Text(favoriteModel.statusCar.toString()),
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
                                "${AppLocalizations.of(context).brand} : ${favoriteModel.brand} ${favoriteModel.model}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                          // Text(
                          //     "${AppLocalizations.of(context).city}  : ${saleCar.city}",
                          //     style: TextStyle(
                          //         color: Colors.grey, fontSize: 16.0)),
                          Text(
                              "${AppLocalizations.of(context).km}  : ${favoriteModel.km}",
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
                          Row(children: [
                            IconButton(
                                onPressed: () =>
                                    _launchCall(context, favoriteModel),
                                icon: Icon(Icons.phone, color: Colors.green)),
                            IconButton(
                                onPressed: () =>
                                   _launchMessage(context, favoriteModel),
                                icon: Icon(Icons.message, color: Colors.white)),
                          ]),
                          IconButton(
                              onPressed: () {
                                favoriteCarReference
                                    .doc(snapshot.data.docs[i].id)
                                    .delete();
                                Provider.of<LikeProvider>(context,listen: false).updateLikePro(favoriteModel.postLiked=null);
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
    _launchCall(BuildContext context, FavoriteModel favoriteModel,  ) async {
    final url = 'tel://${favoriteModel.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

   _launchMessage(BuildContext context, FavoriteModel favoriteModel,) async {
    final url = 'sms://${favoriteModel.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
