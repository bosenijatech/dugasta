// App icons.
import 'package:flutter/material.dart';

const String userIcon = "assets/icons/user.svg";
const String lockIcon = "assets/icons/Lock.svg";
const String emailIcon = "assets/icons/email.svg";

//App Colors.
const Color bgColor = Color(0xfff4f4f4);
const Color kTextColor = Color(0xff1C1939);
const Color kInputBorderColor = Color(0xff1F363D);
const Color kLightTextColor = Color(0xff1C1939);
const Color kBlackColor = Colors.black;
const Color kWhiteColor = Colors.white;

// app Images

const String logoImage = "assets/images/logo.png";
class AppAssets{
static const String home = 'assets/svgimages/home.svg';
static const String call = 'assets/svgimages/call.svg';
static const String setting = 'assets/svgimages/setting.svg';
static const String home_full = 'assets/svgimages/home_full.svg';
static const String call_full = 'assets/svgimages/call_full.svg';
static const String setting_full = 'assets/svgimages/setting_full.svg';
static const String feedback = 'assets/svgimages/feedback.svg';
static const String feedback_full = 'assets/svgimages/feedback_full.svg';
static const String profile = 'assets/svgimages/profile.svg';
static const String profile_full = 'assets/svgimages/profile_full.svg';
static const String contracts = 'assets/images/contracts.png';
static const String payment = 'assets/images/payment.png';
static const String service  = 'assets/images/service.png';
static const String apartment = 'assets/images/apartment.png';
static const String FAQ = 'assets/images/FAQ.png';
static const String appointment = 'assets/images/appointment.png';
static const String statement = 'assets/images/statement.png';
static const String reservation = 'assets/images/reservation.png';
static const String estimate = 'assets/images/estimate.png';
static const String building1 = 'assets/images/building1.png';
static const String carousel1 = 'assets/images/carousel1.png';
static const String carousel2 = 'assets/images/carousel2.png';
static const String carousel3 = 'assets/images/carousel3.jpg';


}

// App Theme Data

ThemeData? appTheme = ThemeData(
  fontFamily: "Montserrat",
  scaffoldBackgroundColor: bgColor,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 32,
      color: kTextColor,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      color: kWhiteColor,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      color: kLightTextColor,
      fontWeight: FontWeight.w600,
    ),
  ),
  // elevatedButtonTheme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: kBlackColor,
      minimumSize: const Size.fromHeight(64),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
      backgroundColor: kBlackColor,
    ),
  ),
  // TextField Theme
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 22.0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: kInputBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kInputBorderColor),
      borderRadius: BorderRadius.circular(10),
    ),
    hintStyle: const TextStyle(
      fontSize: 16,
      color: kLightTextColor,
      fontWeight: FontWeight.w600,
    ),
  ),
);
