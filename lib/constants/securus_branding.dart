import 'package:flutter/material.dart';

class SecurusColors {
  SecurusColors._();

  static const Color primary = Color(0xFF4267B2);
  static const Color scaffoldBackground = Color(0xFFF5F5F5); // Colors.grey[100]
  static const Color primaryText = Color(0xFF000000); // Black87 equivalent
  static const Color secondaryText = Color(0xFF757575); // Grey[600] equivalent
  static const Color tertiaryText = Color(0xFF9E9E9E); // Grey[500] equivalent
  static const Color cardBackground = Color(0xFFFFFFFF); // White
  static const Color divider = Color(0xFFE0E0E0); // Grey[300] equivalent
  static const Color disabledButton = Color(0xFF9E9E9E); // Grey equivalent
  static const Color loadingOverlay =
      Color(0xB3FFFFFF); // White with 70% opacity
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color error = Color(0xFFD32F2F); // Red
  static const Color warning = Color(0xFFFFA000); // Amber

  static MaterialColor primarySwatch = MaterialColor(
    primary.value,
    <int, Color>{
      50: Color(0xFFE7EBF3),
      100: Color(0xFFC2CEE2),
      200: Color(0xFF99AECF),
      300: Color(0xFF708DBC),
      400: Color(0xFF5274AD),
      500: primary, // 0xFF4267B2
      600: Color(0xFF3C5FA5),
      700: Color(0xFF345495),
      800: Color(0xFF2C4A86),
      900: Color(0xFF1E3A6B),
    },
  );

  /// Helper method to get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
