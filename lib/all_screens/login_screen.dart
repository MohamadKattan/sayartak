import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/all_screens/Registr_screen.dart';
import 'package:sayartak/all_screens/home_screen.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/provider/current_user_provider.dart';
import 'package:sayartak/service/auth_email_pasWord.dart';
import 'package:sayartak/service/facebooc_sing_in.dart';
import 'package:sayartak/service/google_sing_in.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:sayartak/widget/custom_text_failed.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  GoogleAuthSingIn _googleAuthSingIn = GoogleAuthSingIn();
  LoginByEmailAuth _loginByEmailAuth = LoginByEmailAuth();
  FaceBookSingIn _bookSingIn = FaceBookSingIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text("Login"),
        centerTitle: false,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            isLoading ? CustomCircular() : Text(""),
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 17 / 100,
                    child: Image.asset(
                      "images/splash.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      child: customTextField(
                        obscureText: false,
                        labelText: "email",
                        minLines: 1,
                        maxLines: 1,
                        controller: emailTextEditingController,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      child: customTextField(
                        obscureText: true,
                        labelText: "PassWord",
                        minLines: 1,
                        maxLines: 1,
                        controller: passWordTextEditingController,
                        textInputType: TextInputType.visiblePassword,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () async {
                          await checkInfoInput(context).whenComplete(() {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            height: 60.0,
                            child: Center(
                                child: Text("Login",
                                    style: TextStyle(color: Colors.white))))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already don\'t have an account : ",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text("Register",
                            style: TextStyle(
                                color: Colors.redAccent[700],
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Center(child: Text("or")),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _googleAuthSingIn.signInWithGoogle();
                          pushToHomePage();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent[700],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            height: 60.0,
                            child: Center(
                                child: Text("Login by google account",
                                    style: TextStyle(color: Colors.white))))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _bookSingIn
                            .signInWithFacebook()
                            .whenComplete(() => pushToHomePage());
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          height: 60.0,
                          child: Center(
                              child: Text("Login by face bock",
                                  style: TextStyle(color: Colors.white)))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkInfoInput(BuildContext context) async {
    if (emailTextEditingController.text.isEmpty) {
      show("Email can\'t be empty");
    }
    if (passWordTextEditingController.text.isEmpty) {
      show("PassWord can\'t be empty");
    } else {
      setState(() {
        isLoading = true;
      });
      await _loginByEmailAuth.signIn(context);
    }
  }

  Future<User> getCurrentUser() async {
    currentUser = auth.currentUser;
    await Provider.of<CurrentUserProvider>(context, listen: false)
        .getProviderCurrentUser(currentUser);
    return currentUser;
  }

  Future<void> show(String msg) async {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void pushToHomePage() {
    setState(() {
      isLoading = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
