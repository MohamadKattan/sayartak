import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/all_screens/splash_screen.dart';
import 'package:sayartak/provider/addCar.dart';
import 'package:sayartak/provider/current_user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddCar()),
        ChangeNotifierProvider(create: (context) => CurrentUserProvider()),
      ],
      child: MaterialApp(
        title: "sayartak",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
