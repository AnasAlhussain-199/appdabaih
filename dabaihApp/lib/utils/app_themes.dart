import 'package:flutter/material.dart';

class AppThemes {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  static final primaryColor = Color(0xff1771a5);
  static final lightGreyColor = Color(0xffF5F5F5);
  static final greyColor = Color(0xff30475E);
  static final darkColor = Color(0xff121212);
  static final greenColor = Colors.green;

  static TextTheme lightTextTheme() {
    return TextTheme(
      headline1: TextStyle(fontSize: 112),
      headline2: TextStyle(fontSize: 56),
      headline3: TextStyle(fontSize: 45),
      headline4: TextStyle(fontSize: 34),
      headline5: TextStyle(fontSize: 24),
      headline6: TextStyle(fontSize: 20),
      subtitle1: TextStyle(fontSize: 16),
      subtitle2: TextStyle(fontSize: 14),
      bodyText1: TextStyle(fontSize: 14),
      bodyText2: TextStyle(fontSize: 14),
      overline: TextStyle(fontSize: 10),
      caption: TextStyle(fontSize: 12),
    );
  }

  ///Light theme
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: createMaterialColor(primaryColor),
      primaryColor: primaryColor,
      fontFamily: 'mohanad',
      scaffoldBackgroundColor: lightGreyColor,
      textTheme: lightTextTheme(),
      appBarTheme: AppBarTheme(
          color: lightGreyColor,
          titleTextStyle: TextStyle(
              color: primaryColor,
              fontFamily: 'mohanad',
              fontSize: 20,
              fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: primaryColor),
          elevation: 0.0,
          centerTitle: true),
      dividerTheme: DividerThemeData(
        color: greyColor,
      ),
      tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: primaryColor,
          unselectedLabelColor: darkColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: AppThemes.darkColor,
        selectedItemColor: AppThemes.primaryColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          //padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(fontFamily: "mohanad")),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }
}
