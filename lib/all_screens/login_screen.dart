import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sayartak/all_screens/Registr_screen.dart';
import 'package:sayartak/all_screens/admin_panel.dart';
import 'package:sayartak/confige.dart';
import 'package:sayartak/service/auth_service.dart';
import 'package:sayartak/widget/custom_circuler_progses.dart';
import 'package:sayartak/widget/custom_text_failed.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: GestureDetector(
            onLongPress: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPanel())),
            child: Text(AppLocalizations.of(context).login)),
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
                        labelText: AppLocalizations.of(context).email,
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
                        labelText: AppLocalizations.of(context).password,
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
                                child: Text(AppLocalizations.of(context).login,
                                    style: TextStyle(color: Colors.white))))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).noaccount,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(AppLocalizations.of(context).register,
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
                  Center(child: Text(AppLocalizations.of(context).or)),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _authService.signInWithGoogle(context);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent[700],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            height: 60.0,
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context).googlelogin,
                                    style: TextStyle(color: Colors.white))))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _authService.signInWithFacebook(context);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          height: 60.0,
                          child: Center(
                              child: Text(AppLocalizations.of(context).facebook,
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
      show(AppLocalizations.of(context).show1);
    }
    if (passWordTextEditingController.text.isEmpty) {
      show(AppLocalizations.of(context).show2);
    } else {
      setState(() {
        isLoading = true;
      });
      await _authService.signIn(context);
    }
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
}
