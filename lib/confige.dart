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

