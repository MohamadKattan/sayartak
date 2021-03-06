import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();
User currentUser;
bool isLoading = false;
CollectionReference usersSet = FirebaseFirestore.instance.collection('users');
final ScrollController scrollController = ScrollController();
TextEditingController nameTextEditingController = TextEditingController();
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passWordTextEditingController = TextEditingController();
///here for add car
CollectionReference saleCarReference = FirebaseFirestore.instance.collection('saleCar');
CollectionReference favoriteCarReference = FirebaseFirestore.instance.collection('favorite');
TextEditingController brandTextEditingController = TextEditingController();
TextEditingController modelTextEditingController = TextEditingController();
TextEditingController cityTextEditingController = TextEditingController();
TextEditingController gearTextEditingController = TextEditingController();
TextEditingController colorTextEditingController = TextEditingController();
TextEditingController gazTextEditingController = TextEditingController();
TextEditingController kmTextEditingController = TextEditingController();
TextEditingController priceTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();
TextEditingController notTextEditingController = TextEditingController();
TextEditingController galleryNameEditingController = TextEditingController();
final TextEditingController maxWidthController = TextEditingController();
final TextEditingController maxHeightController = TextEditingController();
final TextEditingController qualityController = TextEditingController();
///here for add new gallery
CollectionReference newGalleryReference = FirebaseFirestore.instance.collection('galleries');
TextEditingController nameGalleryEditingController = TextEditingController();
TextEditingController address1GalleryEditingController = TextEditingController();
TextEditingController address2GalleryEditingController = TextEditingController();
TextEditingController phoneGalleryEditingController = TextEditingController();
TextEditingController locationGalleryEditingController = TextEditingController();
TextEditingController numberIdGalleryEditingController = TextEditingController();
///here for admin add car
CollectionReference adminAddCarReference = FirebaseFirestore.instance.collection('adminAddCar');
///here for admin set notification to fireStore
CollectionReference adminNotificationReference = FirebaseFirestore.instance.collection('notification');