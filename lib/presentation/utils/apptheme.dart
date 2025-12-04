import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'WorkSans';
    return base.copyWith();
  }


  static const primarycolor = Color(0xFF0D0D0D);
  static const primary =Color(0xFF0D0D0D);



  // 🔹 Secondary – Pure White (contrast, readability)
  static const Color secondaryColor = Color(0xFFFFFFFF);

  // 🔹 Accent – Gold (luxury highlight)
  static const Color accentColor = Color(0xFFD4AF37);

  // 🔹 Support – Emerald Green (optional luxury vibe)
  static const Color supportColor = Color(0xFF2E7D32);

  // 🔹 Neutral Gray (for secondary text, icons)
  static const Color textGray = Color(0xFFBDBDBD);

  // static ThemeData buildLightTheme() {
  //   final Color primaryColor = Color(0xFF009cd6);
  //   final Color secondaryColor = Color(0xFF009cd6);
  //   final ColorScheme colorScheme = const ColorScheme.light().copyWith(
  //     primary: primaryColor,
  //     secondary: secondaryColor,
  //   );
  //   final ThemeData base = ThemeData.light();
  //   return base.copyWith(
  //     primaryColor: primaryColor,
  //     indicatorColor: Colors.white,
  //     splashColor: Colors.white24,
  //     splashFactory: InkRipple.splashFactory,
  //     canvasColor: Colors.white,
  //     scaffoldBackgroundColor: const Color(0xFFF6F6F6),
  //     buttonTheme: ButtonThemeData(
  //       colorScheme: colorScheme,
  //       textTheme: ButtonTextTheme.primary,
  //     ),
  //     cardColor: Colors.white,
  //     textTheme: _buildTextTheme(base.textTheme),
  //     primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  //     platform: TargetPlatform.iOS,
  //     colorScheme: colorScheme
  //         .copyWith(surface: const Color(0xFFFFFFFF))
  //         .copyWith(error: const Color(0xFFB00020)),
  //   );
  // }
}
