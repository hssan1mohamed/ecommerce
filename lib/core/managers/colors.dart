
import 'package:flutter/material.dart';

class AppColors {
 static const Color primaryColor = Color(0xFF00796B);
 static const Color secondaryColor = Color(0xFF4CAF50);
 static const Color redColor = Colors.red;
 static const Color accentColor = Color(0xFFFFC107);
 static const Color textColor = Color(0xFF333333);
 static const Color backgroundColor = Color(0xFFE0E0E0);
 // Define the primary color
 static const int _primaryColorValue = 0xFF00796B;

 // Create a MaterialColor using the primary color
 static const MaterialColor primaryMaterialColor =
 MaterialColor(_primaryColorValue, <int, Color>{
  50: Color(0xFFE0F2F1),
  100: Color(0xFFB2DFDB),
  200: Color(0xFF80CBC4),
  300: Color(0xFF4DB6AC),
  400: Color(0xFF26A69A),
  500: Color(_primaryColorValue), // Primary color
  600: Color(0xFF00897B),
  700: Color(0xFF00796B),
  800: Color(0xFF00695C),
  900: Color(0xFF004D40),
 });
}

// Color redColor=   HexColor('#C70000');
// Color mainColor=    HexColor('#07094D').withOpacity(0.6);
//  Color buttonColor= HexColor('#07094D');
//  Color textBoxColor= const Color(0xff17BEBB);
//  Color textColor= const Color(0xff4B1D3F);
//  Color antherColor= const Color(0xffD62246);
