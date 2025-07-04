import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A centralized class for all theme-related constants and definitions.
class AppTheme {
  // ignore: prefer_typing_uninitialized_variables
  static var borderColor;

  // Private constructor to prevent instantiation.
  AppTheme._();

  // --- COLOR CONSTANTS ---
  // These colors are sampled directly from the provided image.

  /// The main dark background color of the app.
  static const Color background = Color.fromARGB(255, 30, 28, 27);

  /// The slightly lighter background color for cards and containers.
  static const Color cardBackground = Color(0xFF2A2827);

  /// The light, parchment-like color for headers and important text.
  static const Color primaryText = Color(0xFFE0D5C4);

  /// The pure white color for values and secondary text.
  static const Color secondaryText = Color(0xFFFFFFFF);

  /// The color for dividers and subtle borders.
  static const Color divider = Color(0xFF4C4A49);

  /// An accent color, seen in the 'on' state of the inspiration switch.
  static const Color accent = Color(0xFF8A6DC2);

  // --- FONT FAMILies ---
  static final String _headerFontFamily = GoogleFonts.cinzel().fontFamily!;
  // ignore: unused_field
  static final String _bodyFontFamily = GoogleFonts.lato().fontFamily!;

  // --- THEME DATA ---

  /// The main dark theme for the application.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: primaryText,

    // --- COLOR SCHEME ---
    // The modern way to define theme colors.
    colorScheme: const ColorScheme.dark(
      primary: primaryText, // Main interactive color (e.g., text headers)
      secondary: accent, // Accent color (e.g., for switches, FABs)
      surface: cardBackground, // Color of component surfaces like Cards
      background: background, // Scaffold background
      onPrimary: background, // Text/icon color on top of primary color
      onSecondary: secondaryText, // Text/icon color on top of secondary color
      onSurface: secondaryText, // Text/icon color on top of surface color
      onBackground: primaryText, // Text/icon color on top of background color
      error: Colors.redAccent,
      onError: secondaryText,
    ),

    // --- TEXT THEME ---
    // Defines default text styles. We use Cinzel for headers and Lato for body.
    textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme).copyWith(
      // For character name: Alistair Thorne
      displayMedium: TextStyle(
          fontFamily: _headerFontFamily,
          color: primaryText,
          fontWeight: FontWeight.bold),
      // For section titles: Ability Scores, Saving Throws & Skills
      headlineSmall: TextStyle(
          fontFamily: _headerFontFamily,
          color: primaryText,
          fontWeight: FontWeight.bold),
      // For general text and values in cards
      bodyLarge: const TextStyle(color: secondaryText, fontSize: 16),
      // For skill names and other labels
      bodyMedium: const TextStyle(color: primaryText, fontSize: 16),
      // For bottom navigation bar labels
      bodySmall: const TextStyle(color: primaryText, fontSize: 12),
    ),

    // --- COMPONENT THEMES ---

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

    // Style for the ability score cards
    cardTheme: CardTheme(
      color: cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.zero,
    ),

    // Style for the dividers between skills
    dividerTheme: const DividerThemeData(
      color: divider,
      thickness: 1,
      space: 1,
    ),

    // Style for the inspiration toggle switch
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return secondaryText; // White thumb when 'on'
        }
        return null; // Default greyish thumb when 'off'
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return accent; // Purple track when 'on'
        }
        return null; // Default grey track when 'off'
      }),
    ),

    // Style for the bottom navigation bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: background,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryText,
      unselectedItemColor: primaryText,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),

    // Default style for all icons
    iconTheme: const IconThemeData(
      color: secondaryText,
      size: 24.0,
    ),
  );
}
