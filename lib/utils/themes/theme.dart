import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ignore: prefer_typing_uninitialized_variables
  static var borderColor;

  AppTheme._();

  static const Color background = Color.fromARGB(255, 30, 28, 27);

  static const Color cardBackground = Color(0xFF2A2827);

  static const Color primaryText = Color(0xFFE0D5C4);

  static const Color secondaryText = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFF4C4A49);

  static const Color accent = Color(0xFF8A6DC2);

  static final String _headerFontFamily = GoogleFonts.cinzel().fontFamily!;

  // static final String _bodyFontFamily = GoogleFonts.lato().fontFamily!;

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: primaryText,
    colorScheme: const ColorScheme.dark(
      primary: primaryText,
      secondary: accent,
      surface: cardBackground,
      background: background,
      onPrimary: background,
      onSecondary: secondaryText,
      onSurface: secondaryText,
      onBackground: primaryText,
      error: Colors.redAccent,
      onError: secondaryText,
    ),
    textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme).copyWith(
      displayMedium: TextStyle(
          fontFamily: _headerFontFamily,
          color: primaryText,
          fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          fontFamily: _headerFontFamily,
          color: primaryText,
          fontWeight: FontWeight.bold),
      bodyLarge: const TextStyle(color: secondaryText, fontSize: 16),
      bodyMedium: const TextStyle(color: primaryText, fontSize: 16),
      bodySmall: const TextStyle(color: primaryText, fontSize: 12),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: _headerFontFamily,
        color: primaryText,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: secondaryText),
    ),
    cardTheme: CardTheme(
      color: cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.zero,
    ),
    dividerTheme: const DividerThemeData(
      color: divider,
      thickness: 1,
      space: 1,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return secondaryText;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return accent;
        }
        return null;
      }),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: background,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryText,
      unselectedItemColor: primaryText,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    iconTheme: const IconThemeData(
      color: secondaryText,
      size: 24.0,
    ),
  );
}
