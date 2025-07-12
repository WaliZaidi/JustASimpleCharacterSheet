// import 'package:dnd_app_v2/services/app_services/characters_service.dart';
// import 'package:dnd_app_v2/widgets/core/base_view_model.dart';
// import 'package:flutter/material.dart';

// import '../../../models/class_model.dart';
// import 'character_sheet_state.dart';

// class CharacterSheetViewModel extends BaseViewModel {
//   var character = const CharacterSheetState();

//   CharacterSheetState build() {
//     // --- 1. Load the raw class data ---
//     final rawClasses = CharacterService.instance.characterList;
//     final sorcererClass = rawClasses.firstWhere((c) => c.name == 'Sorcerer');
//     final warlockClass = rawClasses.firstWhere((c) => c.name == 'Warlock');

//     // --- 2. Define character-specific base data (from sheet) ---
//     final Map<DndClass, int> characterClasses = {
//       sorcererClass: 3,
//       warlockClass: 1,
//     };
//     const totalLevel = 4;

//     final Map<String, int> abilityScores = {
//       'Strength': 8,
//       'Dexterity': 16,
//       'Constitution': 16,
//       'Intelligence': 14,
//       'Wisdom': 14,
//       'Charisma': 18,
//     };

//     // --- 3. Calculate derived stats ---
//     final proficiencyBonus =
//         ((totalLevel - 1) / 4).floor() + 2; // e.g., +2 for levels 1-4

//     final abilityModifiers = abilityScores.map(
//       (key, value) => MapEntry(key, (value - 10) ~/ 2),
//     );

//     // Get all features for the character's level in each class
//     final List<ClassFeature> features = [];
//     characterClasses.forEach((dndClass, level) {
//       features.addAll(dndClass.features.where((f) => f.level <= level));
//     });

//     // Skill bonuses are hardcoded from the sheet for this example
//     final Map<String, int> skillBonuses = {
//       'Athletics': -1,
//       'Acrobatics': 3,
//       'Sleight of Hand': 3,
//       'Stealth': 5,
//       'Arcana': 2,
//       'History': 2,
//       'Investigation': 4,
//       'Nature': 4,
//       'Religion': 2,
//       'Animal Handling': 2,
//       'Insight': 2,
//       'Medicine': 4,
//       'Perception': 4,
//       'Survival': 2,
//       'Deception': 6,
//       'Intimidation': 4,
//       'Performance': 4,
//       'Persuasion': 6,
//     };

//     // --- 4. Assemble the final state object ---
//     character = CharacterSheetState(
//       characterName: 'Mahr Mudborn',
//       race: 'Hexblood',
//       alignment: 'Neutral Good',
//       background: 'Criminal (Spy)',
//       imagePath: 'assets/character_portrait.png', // Add your image to assets
//       characterClasses: characterClasses,
//       abilityScores: abilityScores,
//       abilityModifiers: abilityModifiers,
//       proficiencyBonus: proficiencyBonus,
//       hitPoints: 32,
//       armorClass: 13,
//       initiative: abilityModifiers['Dexterity']!,
//       speed: 30,
//       skillBonuses: skillBonuses,
//       features: features,
//       personalityTraits:
//           'I would rather make a new friend than a new enemy, and expand my circle of contacts that I could reach out to do favors and receive help from.',
//       ideals:
//           'Charity. I steal from the wealthy so that I can help the people in need. Since I relied on charity myself to survive, I feel like its the least I can do.',
//       bonds:
//           'I\'m guilty of a terrible crime. I hope I can redeem myself for it. Mostly it\'s the crime of being stupid enough to try and steal from a hag. But I feel remorse.',
//       flaws:
//           'An innocent person is in prison for a crime that I committed. I\'m okay with that. It was because they had the potential to become a target for an opp, so I put them in the safest place in the city - the jail.',
//     );

//     return character;
//   }

//   /// Example of a method the UI could call to update state.
//   void setHitPoints(String value) {
//     final hp = int.tryParse(value) ?? character.hitPoints;
//     character = character.copyWith(hitPoints: hp);
//   }

//   @override
//   void initState(BuildContext context) {}

//   @override
//   void resetState() {}
// }

import 'package:flutter/material.dart';
// Adjust imports as needed
import 'character_sheet_state.dart';
import '../../../models/class_model.dart';
import 'package:dnd_app_v2/services/app_services/characters_service.dart';
import 'package:dnd_app_v2/widgets/core/base_view_model.dart';

class CharacterSheetViewModel extends BaseViewModel {
  var character = CharacterSheetState();

  CharacterSheetState build() {
    // --- Data loading... (same as before) ---
    final rawClasses = CharacterService.instance.characterList;
    final sorcererClass = rawClasses.firstWhere((c) => c.name == 'Sorcerer');
    final warlockClass = rawClasses.firstWhere((c) => c.name == 'Warlock');
    final Map<DndClass, int> characterClasses = {
      sorcererClass: 3,
      warlockClass: 1
    };
    const totalLevel = 4;
    final Map<String, int> abilityScores = {
      'Strength': 8,
      'Dexterity': 16,
      'Constitution': 16,
      'Intelligence': 14,
      'Wisdom': 14,
      'Charisma': 18
    };
    final proficiencyBonus = ((totalLevel - 1) / 4).floor() + 2;
    final abilityModifiers =
        abilityScores.map((key, value) => MapEntry(key, (value - 10) ~/ 2));
    final List<ClassFeature> features = [];
    characterClasses.forEach((dndClass, level) {
      features.addAll(dndClass.features.where((f) => f.level <= level));
    });
    final Map<String, int> skillBonuses = {
      'Athletics': -1,
      'Acrobatics': 3,
      'Sleight of Hand': 3,
      'Stealth': 5,
      'Arcana': 2,
      'History': 2,
      'Investigation': 4,
      'Nature': 4,
      'Religion': 2,
      'Animal Handling': 2,
      'Insight': 2,
      'Medicine': 4,
      'Perception': 4,
      'Survival': 2,
      'Deception': 6,
      'Intimidation': 4,
      'Performance': 4,
      'Persuasion': 6
    };

    // --- NEW: Assemble Biography Entries ---
    final List<BioEntry> biographyEntries = [
      const BioEntry(
          title: 'Personality Traits',
          text: 'I would rather make a new friend than a new enemy...'),
      const BioEntry(
          title: 'Ideals',
          text: 'Charity. I steal from the wealthy so that I can help...'),
      const BioEntry(
          title: 'Bonds',
          text:
              'I\'m guilty of a terrible crime. I hope I can redeem myself...'),
      const BioEntry(
          title: 'Flaws',
          text:
              'An innocent person is in prison for a crime that I committed...'),
    ];

    character = CharacterSheetState(
      characterName: 'Mahr Mudborn',
      race: 'Hexblood',
      background: 'Criminal (Spy)',
      imagePath: 'assets/character_portrait.png',
      characterClasses: characterClasses,
      abilityScores: abilityScores,
      abilityModifiers: abilityModifiers,
      proficiencyBonus: proficiencyBonus,
      hitPoints: 32,
      armorClass: 13,
      initiative: abilityModifiers['Dexterity']!,
      speed: 30,
      skillBonuses: skillBonuses,
      features: features,
      biographyEntries: biographyEntries, // Use the new list
    );

    return character;
  }

  // --- NEW: Methods to update state ---

  void updateHitPoints(int newHp) {
    character = character.copyWith(hitPoints: newHp);
    // In a real app with StateNotifier:
    // state = state.copyWith(hitPoints: newHp);
    notifyListeners();
  }

  void updateArmorClass(int newAc) {
    character = character.copyWith(armorClass: newAc);
    notifyListeners();
  }

  void updateSpeed(int newSpeed) {
    character = character.copyWith(speed: newSpeed);
    notifyListeners();
  }

  Future<void> addFeature(ClassFeature newFeature) async {
    print(character.features.length);

    final updatedFeatures = List<ClassFeature>.from(character.features)
      ..add(newFeature);
    character.features = updatedFeatures;
    print(newFeature.toJson());
    print(character.features.length);
    notifyListeners();
  }

  void addBioEntry(BioEntry newEntry) {
    final updatedEntries = List<BioEntry>.from(character.biographyEntries)
      ..add(newEntry);
    character.biographyEntries = updatedEntries;
    notifyListeners();
  }

  @override
  void initState(BuildContext context) {}

  @override
  void resetState() {}
}
