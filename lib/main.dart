import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sayartak/all_screens/splash_screen.dart';
import 'package:sayartak/provider/addCar.dart';
import 'package:sayartak/provider/like_provider.dart';
import 'package:sayartak/provider/notifiction_provider.dart';
import 'package:sayartak/service/locale_notficition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        ChangeNotifierProvider(create: (context) => LocaleNotifications()),
        ChangeNotifierProvider(create: (context) => NotifictionIndex()),
        ChangeNotifierProvider(create: (context) => LikeProvider()),
      ],
      child: MaterialApp(
        title: "sayartak",
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

