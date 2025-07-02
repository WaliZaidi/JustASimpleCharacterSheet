// import 'package:flutter/material.dart';

// void main() {
//   runApp(const JustASimpleCharacterSheet());
// }

// class JustASimpleCharacterSheet extends StatelessWidget {
//   const JustASimpleCharacterSheet({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const JustASimpleCharacterSheet(),
//       //meow
//     );
//   }
// }

// lib/main.dart

import 'package:flutter/material.dart';
import 'models/character_model.dart';
import 'screens/combat/combat_view.dart';
import 'screens/profile/profile_view.dart';
import 'screens/skills/skills_feature_view.dart';
import 'widgets/core/bottom_pagination_bar.dart';

void main() {
  runApp(const DndSheetApp());
}

class DndSheetApp extends StatelessWidget {
  const DndSheetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D&D Character Sheet',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        primaryColor: Colors.red.shade800,
        scaffoldBackgroundColor: const Color(0xFF1a1a1a),
        cardColor: const Color(0xFFfdf6e4), // Parchment color
        textTheme: TextTheme(
          // For light-colored cards
          displayLarge: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
          displayMedium: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
          displaySmall: const TextStyle(color: Colors.black87),
          headlineMedium: const TextStyle(color: Colors.black87),
          headlineSmall: const TextStyle(
              color: Color.fromARGB(255, 100, 80, 80),
              fontWeight: FontWeight.bold), // For section headers on dark bg
          titleLarge: const TextStyle(color: Colors.black87),
          titleMedium: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
          bodyLarge: const TextStyle(color: Colors.black87, fontSize: 16),
          bodyMedium: const TextStyle(color: Colors.black87),
          bodySmall: TextStyle(color: Colors.grey.shade600),
        ),
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.red, brightness: Brightness.dark)
            .copyWith(secondary: Colors.red.shade600),
        useMaterial3: true,
      ),
      home: const CharacterSheetWrapper(),
    );
  }
}

class CharacterSheetWrapper extends StatefulWidget {
  const CharacterSheetWrapper({Key? key}) : super(key: key);

  @override
  State<CharacterSheetWrapper> createState() => _CharacterSheetWrapperState();
}

class _CharacterSheetWrapperState extends State<CharacterSheetWrapper> {
  int _selectedIndex = 0;
  final Character character = mahrMudborn;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      CombatPage(character: character),
      SkillsFeaturesPage(character: character),
      ProfilePage(character: character),
    ];
  }

  // ignore: unused_element
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${character.name} - ${character.mainClass}'),
          backgroundColor: const Color(0xFF333333),
        ),
        body: IndexedStack(
          // Use IndexedStack to keep page state
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: const BottomPaginationBar());
  }
}
