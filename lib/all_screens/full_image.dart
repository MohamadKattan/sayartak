import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';

class FullImage extends StatelessWidget {
  final String image;
  FullImage({this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: ()=>Navigator.pop(context),
        child: PhotoView(
          imageProvider: Image.network(image,fit: BoxFit.cover,).image,
          heroAttributes: PhotoViewHeroAttributes (tag: "someTag"),
        ),
      ),
    );
  }
}
