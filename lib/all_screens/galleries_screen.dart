import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/home_screen.dart';
import 'package:sayartak/all_screens/login_screen.dart';
import 'package:sayartak/widget/list_of_galleries.dart';

class GalleriesScreen extends StatelessWidget {
  Galleries _galleries = Galleries();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Galleries"),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            _galleries.gallery1(),
            _galleries.gallery2(),
            _galleries.gallery3(),
            _galleries.gallery4(),
            _galleries.gallery5(),
            _galleries.gallery6(),
            _galleries.gallery7(),
            _galleries.gallery8(),
            _galleries.gallery9(),
            _galleries.gallery10(),
          ],
        ));
  }
}
