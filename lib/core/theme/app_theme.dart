import 'package:flutter/material.dart';

class AppColors {
  // Primary & Surface Canvas
  static const Color mainLightCanvas = Color(0xFFF8F9FF);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color darkCanvas = Color(0xFF0F172A); // Deep slate near-black
  static const Color darkCardSurface = Color(0xFF1E293B);

  // Brand / Primary Colors
  static const Color primaryDarkSlate = Color(0xFF0F172A);
  static const Color textHighEmphasis = Color(0xFF0B1C30);
  static const Color secondaryBlue = Color(0xFF0284C7);
  static const Color infoLightBlue = Color(0xFFE0F2FE);

  // Light-blue containers
  static const Color blueContainerLight = Color(0xFFEFF4FF);
  static const Color blueContainerMedium = Color(0xFFE5EEFF);
  static const Color blueContainerDark = Color(0xFFDCE9FF);

  // Disruption & Action Orange
  static const Color disruptionOrange = Color(0xFFEA580C);
  static const Color warningLightSurface = Color(0xFFFFF7ED);
  static const Color warningBorder = Color(0xFFFDBA74);

  // Success Green
  static const Color successGreen = Color(0xFF16A34A);
  static const Color successLightSurface = Color(0xFFDCFCE7);

  // Error & Outline
  static const Color errorRed = Color(0xFFBA1A1A);
  static const Color errorLightSurface = Color(0xFFFFDAD6);
  static const Color outline = Color(0xFFE2E8F0);
  static const Color mutedText = Color(0xFF64748B);
  static const Color divider = Color(0xFFF1F5F9);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  static const double gutter = 16.0;
  static const double cardRadius = 16.0;
  static const double nestedCardRadius = 8.0;
  static const double buttonRadius = 12.0;
  static const double pillRadius = 999.0;
}

class AppTypography {
  static const String fontFamily = 'Inter';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    height: 44 / 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle mobileDisplay = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    height: 38 / 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    height: 34 / 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle mobileHeadlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.normal,
    color: AppColors.mutedText,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textHighEmphasis,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    height: 14 / 10,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedText,
  );

  static const TextStyle dataMetric = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 26 / 20,
    fontWeight: FontWeight.bold,
    fontFeatures: [FontFeature.tabularFigures()],
    color: AppColors.textHighEmphasis,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.mainLightCanvas,
      primaryColor: AppColors.primaryDarkSlate,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryDarkSlate,
        secondary: AppColors.secondaryBlue,
        surface: AppColors.cardSurface,
        error: AppColors.errorRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textHighEmphasis,
        onError: Colors.white,
      ),
      fontFamily: AppTypography.fontFamily,
      cardTheme: CardTheme(
        color: AppColors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: const BorderSide(color: AppColors.outline, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.primaryDarkSlate),
        titleTextStyle: AppTypography.headlineMedium,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkCanvas,
      primaryColor: AppColors.secondaryBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.secondaryBlue,
        secondary: AppColors.disruptionOrange,
        surface: AppColors.darkCardSurface,
        error: AppColors.errorRed,
        onPrimary: Colors.white,
        onSurface: Colors.white,
      ),
      fontFamily: AppTypography.fontFamily,
    );
  }
}
