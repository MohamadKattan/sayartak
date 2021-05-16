import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/car_details.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/model/sale_car_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SaleCar> saleCarList;
  String query = '';
  TextEditingController searchEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchAllCars().then((List<SaleCar> car) => saleCarList = car);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchUserAppBar(context),
      body: buildSuggestions(query),
    );
  }

  //this method for result search ALL users from firebase
  Future<List<SaleCar>> fetchAllCars() async {
    saleCarList = List<SaleCar>();
    QuerySnapshot querySnapshot = await saleCarReference.get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      saleCarList.add(SaleCar.fromMap(querySnapshot.docs[i].data()));
    }
    return saleCarList;
  }

  //  this appBar
  searchUserAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left:8.0,right: 8.0),
          child: TextField(
            controller: searchEditingController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: Colors.red,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => searchEditingController.clear());
                },
              ),
              border: InputBorder.none,
              hintText:AppLocalizations.of(context).search,
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // this method for show resulut search user in list view
  buildSuggestions(String query) {
    //1-- here when we start type on text failed will start see some sugget useer
    List<SaleCar> suggestList = query.isEmpty
        ? []
        : saleCarList.where((SaleCar cars) {
            String _getuserName = cars.brand.toLowerCase();
            String _getName = cars.model.toLowerCase();
            String _query = query.toLowerCase();
            bool matchUserName = _getuserName.contains(_query);
            bool matchName = _getName.contains(_query);
            return (matchName || matchUserName);
          }).toList();
    // 2-- it will put data from result in list view
    return ListView.builder(
        itemCount: suggestList.length,
        itemBuilder: (context, index) {
          SaleCar searchedCar = SaleCar(
            postId: suggestList[index].postId,
            model: suggestList[index].model,
            brand: suggestList[index].brand,
            image: suggestList[index].image,
          );
          // 3-- it will show in customtile include listview from the up
          return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CarDetails(saleCarDetails: searchedCar)));
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(searchedCar.image),
                backgroundColor: Colors.grey,
              ),
              title: Text(
                searchedCar.brand,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                searchedCar.model,
                style: TextStyle(color: Colors.grey),
              ));
        });
  }
}
