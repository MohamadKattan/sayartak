import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/full_image.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarDetails extends StatefulWidget {
  final SaleCar saleCarDetails;
  final String idLike;
  CarDetails({this.saleCarDetails, this.idLike});

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(AppLocalizations.of(context).cardetails),
        centerTitle: false,
        actions: [
          !isLiked
              ? IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isLiked=true;
                      iLiked(context);
                    });
                  } )
              : Icon(Icons.favorite, color: Colors.red),
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
                              image: widget.saleCarDetails.image,
                            )));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 40 / 100,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                    tag: "someTag",
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.saleCarDetails.image,
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${AppLocalizations.of(context).brand}:${widget.saleCarDetails.brand} ${widget.saleCarDetails.model}",
                    style: TextStyle(fontSize: 18.0),overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "${AppLocalizations.of(context).price} : ${widget.saleCarDetails.price}",
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                "${AppLocalizations.of(context).installment} : ${widget.saleCarDetails.installment}",
                style: TextStyle(fontSize: 16.0),
              ),
            ]),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).not} :  ${widget.saleCarDetails.not}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).city} :", style: TextStyle(fontSize: 16.0)),
                Text(" ${widget.saleCarDetails.city}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).km}:", style: TextStyle(fontSize: 16.0)),
                Text(" ${widget.saleCarDetails.km}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).gear}:", style: TextStyle(fontSize: 16.0)),
                Text(" ${widget.saleCarDetails.gear}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).gaz}:", style: TextStyle(fontSize: 16.0)),
                Text("${widget.saleCarDetails.gaz}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).brand}:", style: TextStyle(fontSize: 16.0)),
                Text("${widget.saleCarDetails.brand}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).model}:", style: TextStyle(fontSize: 16.0)),
                Text(" ${widget.saleCarDetails.model}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).price}:", style: TextStyle(fontSize: 16.0)),
                Text("\$ ${widget.saleCarDetails.price}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context).statuscar}:", style: TextStyle(fontSize: 16.0)),
                Text(" ${widget.saleCarDetails.statusCar}",
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> iLiked(
    BuildContext context,
  ) async {
    try {
      await favoriteCarReference.doc(widget.idLike).set({
        "postLiked": currentUser.uid.toString(),
        "image": widget.saleCarDetails.image,
        "brand": widget.saleCarDetails.brand,
        "model": widget.saleCarDetails.model,
        "color": widget.saleCarDetails.color,
        "price": widget.saleCarDetails.price,
        "km": widget.saleCarDetails.km,
        "phone": widget.saleCarDetails.phone,
        "statusCar": widget.saleCarDetails.statusCar,
        "installment": widget.saleCarDetails.installment,
      });
    } catch (ex) {}
  }
}
