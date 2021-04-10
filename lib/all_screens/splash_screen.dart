import 'package:flutter/material.dart';
import 'package:sayartak/all_screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String screenId = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0.3,
        upperBound: 0.9
    );
    _animationController.forward();
    _animationController.addStatusListener((status){
      if(status==AnimationStatus.completed){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScaleTransition(
        scale: _animationController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage("images/splash.png"),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
}
