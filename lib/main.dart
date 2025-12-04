import 'dart:io';

import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/overridehttp.dart';
import 'package:dugasta/presentation/module/splash.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dugasta/resultdashboard.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isAndroid) {
  //   await Firebase.initializeApp();
  //   await NotificationService.instance.initialize();
  // } else {
  //   await Firebase.initializeApp();
  //   await NotificationService.instance.initialize();
  // }
  await Prefs.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dugasta',
      debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //   scaffoldBackgroundColor: bgColor,
      //   primarySwatch: Colors.blue,
      //   fontFamily: "Gordita",
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //   ),
      //   textTheme: const TextTheme(
      //     bodyText2: TextStyle(color: Colors.black54),
      //   ),
      // ),
      navigatorKey: navigatorKey,
      theme: ThemeData(
         fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: AppColor.primary,
        ),
        // textTheme: GoogleFonts.sourceSerif4TextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColor.primary,
      //   cardTheme:  
      //   CardTheme(
      //     elevation: 1,
      //     surfaceTintColor: Colors.white,
      //     color: Colors.white,
      //   ),
      ),
      home: SplashScreen(),
    );
  }
}
