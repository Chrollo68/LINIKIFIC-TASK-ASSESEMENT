import 'package:flutter/material.dart';

/// Custom Color Palette for the application
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryLight = Color(0xFF7C3AED);
  static const Color primaryDark = Color(0xFF5A189A);

  // Secondary Colors
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryLight = Color(0xFF1DE9B6);
  static const Color secondaryDark = Color(0xFF00C9A7);

  // Tertiary Colors
  static const Color tertiary = Color(0xFFFF5722);
  static const Color tertiaryLight = Color(0xFFFF7043);
  static const Color tertiaryDark = Color(0xFFE64A19);

  // Background Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color darkBackground = Color(0xFF121212);

  // Surface Colors
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF1E1E1E);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFB3261E);
  static const Color info = Color(0xFF2196F3);

  // Text Colors
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color lightTextDisabled = Color(0xFFBDBDBD);

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextDisabled = Color(0xFF555555);

  // Border Colors
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color darkBorder = Color(0xFF333333);
}

/// Typography Constants
class AppTypography {
  static const double displayLargeSize = 57;
  static const double displayMediumSize = 45;
  static const double headlineLargeSize = 32;
  static const double headlineMediumSize = 28;
  static const double titleLargeSize = 22;
  static const double bodyLargeSize = 16;
  static const double bodyMediumSize = 14;
  static const double labelLargeSize = 14;

  static const String fontFamily = 'Roboto';
}

/// Spacing and Sizing Constants
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Border radius
  static const double radiusSmall = 4;
  static const double radiusMedium = 8;
  static const double radiusLarge = 16;
  static const double radiusXLarge = 28;

  // Elevation
  static const double elevationSmall = 2;
  static const double elevationMedium = 4;
  static const double elevationLarge = 8;
}

/// Responsive Breakpoints
class AppBreakpoints {
  static const double mobileMax = 600;
  static const double tabletMin = 600;
  static const double tabletMax = 1200;
  static const double desktopMin = 1200;
}
