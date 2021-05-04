import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/galleries/galleryno1.dart';
import 'package:sayartak/model/new_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class Galleries {
  gallery1() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "1").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery1(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery2() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "2").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery2(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery3() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "3").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery3(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery4() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "4").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery4(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery5() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "5").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery5(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery6() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "6").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery6(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery7() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "7").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery7(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery8() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "8").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery8(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery9() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "9").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery9(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  gallery10() {
    return StreamBuilder<QuerySnapshot>(
        stream:
        newGalleryReference.where("galleryNo", isEqualTo: "10").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else if (snapshot.connectionState == ConnectionState.active) {
            var gallery = Gallery.fromMap(snapshot.data.docs[0].data());
            return listOfGallery10(gallery, context);
          } else {
            return Text("null");
          }
        });
  }

  listOfGallery1(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => GalleryNo1(stamp: gallery))),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery2(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery3(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery4(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery5(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery6(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery7(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery8(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery9(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  listOfGallery10(Gallery gallery, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 20 / 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: gallery.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: 2,
                ),
              ),
              Text(gallery.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

}