import 'dart:async';

import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/module/landingpage/landingscreen.dart';
import 'package:dugasta/presentation/module/login/login.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getcheckedLoggin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage("assets/images/logo.png"),
                //height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment(0.0, 1.0),
              child: Text(
                "",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 22,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getcheckedLoggin() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    (Prefs.getLoggedIn("IsLoggedIn") == null ||
                            Prefs.getLoggedIn("IsLoggedIn") == false)
                        ? LoginScreen()
                        : (Prefs.getActive("active").toString() == "N"
                            ? LoginScreen()
                            : LandingScreenPage()))));
  }
}
