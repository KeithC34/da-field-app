import 'package:flutter/material.dart';

/// Shared visual language recreated from the Stitch DA Magdalena references.
abstract final class AppTheme {
  static const primary = Color(0xFF154212);
  static const primaryContainer = Color(0xFF2D5A27);
  static const background = Color(0xFFF9FAF2);
  static const surfaceLow = Color(0xFFF3F4ED);
  static const surface = Color(0xFFFFFFFF);
  static const outline = Color(0xFFC2C9BB);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primaryContainer,
      onPrimaryContainer: const Color(0xFF9DD090),
      surface: background,
      onSurface: const Color(0xFF191C18),
      onSurfaceVariant: const Color(0xFF42493E),
      outlineVariant: outline,
      secondaryContainer: const Color(0xFFDCE2F3),
      onSecondaryContainer: const Color(0xFF404754),
      error: const Color(0xFFBA1A1A),
    );

    const radius = BorderRadius.all(Radius.circular(12));
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Color(0xFF191C18),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(fontSize: 20, height: 1.4, fontWeight: FontWeight.w600),
      ),
      cardTheme: const CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: radius, side: BorderSide(color: outline)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
        floatingLabelStyle: const TextStyle(color: primary, fontWeight: FontWeight.w600),
        border: const OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: outline)),
        enabledBorder: const OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: outline)),
        focusedBorder: const OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: primary, width: 2)),
        errorBorder: const OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: Color(0xFFBA1A1A))),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 56),
          shape: const RoundedRectangleBorder(borderRadius: radius),
          textStyle: const TextStyle(fontSize: 14, letterSpacing: .5, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 52),
          shape: const RoundedRectangleBorder(borderRadius: radius),
          side: const BorderSide(color: outline),
          textStyle: const TextStyle(fontSize: 14, letterSpacing: .3, fontWeight: FontWeight.w700),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide.none,
        backgroundColor: surfaceLow,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    );
  }
}
