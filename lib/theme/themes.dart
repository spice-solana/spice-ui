import 'package:flutter/material.dart';

enum AppTheme { ligth, dark }

final apptheme = {
  AppTheme.ligth: ThemeData(
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 18.0,
          letterSpacing: -0.3,
          color: Color(0xFF252525),
          fontFamily: "CPMono",
        ),
        iconTheme: IconThemeData(
          color: Colors.blueGrey.shade300,
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        bodyMedium: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        bodyLarge: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        displaySmall: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        displayLarge: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        displayMedium: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        labelLarge: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        labelMedium: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        labelSmall: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        titleLarge: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        titleMedium: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        titleSmall: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        headlineLarge: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        headlineMedium: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        headlineSmall: TextStyle(
            color: Color(0xFF252525),
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
      ),
      dialogBackgroundColor: Colors.white,
      fontFamily: "CPMono",
      cardColor: const Color(0xFF252525),
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color.fromARGB(255, 0, 0, 0),
      hintColor: Colors.grey.withOpacity(0.3),
      iconTheme: IconThemeData(
        color: Colors.blueGrey.shade300,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        onPrimary: const Color(0xFFA3ADD0),
        primary: Colors.white,
        brightness: Brightness.light,
        primaryContainer: Colors.white,
        secondary: Colors.grey.withOpacity(0.3),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey.withOpacity(0.3),
        selectionColor: const Color(0xFF80EEFB).withOpacity(0.3),
    )),
  AppTheme.dark: ThemeData(
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontSize: 18.0,
          letterSpacing: -0.3,
          color: Colors.white,
          fontFamily: "CPMono",
        ),
        iconTheme: IconThemeData(
          color: Colors.blueGrey.shade300,
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        bodyMedium: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        bodyLarge: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        displaySmall: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        displayLarge: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        displayMedium: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        labelLarge: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        labelMedium: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        labelSmall: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        titleLarge: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        titleMedium: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        titleSmall: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        headlineLarge: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        headlineMedium: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
        headlineSmall: TextStyle(
            color: Colors.white,
            letterSpacing: -0.3,
            fontWeight: FontWeight.normal,
            fontSize: 16.0),
      ),
      dialogBackgroundColor: Colors.grey.shade800,
      fontFamily: "CPMono",
      cardColor: Colors.grey.shade800,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFF0C0E10),
      primaryColor: const Color.fromARGB(255, 24, 30, 37),
      hintColor: Colors.grey.withOpacity(0.2),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          onPrimary: const Color(0xFFA3ADD0),
          primary: Colors.black,
          brightness: Brightness.dark,
          primaryContainer: Colors.black,
          secondary: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.white),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey.withOpacity(0.2),
        selectionColor: const Color(0xFF80EEFB).withOpacity(0.1),    
  )),
};
