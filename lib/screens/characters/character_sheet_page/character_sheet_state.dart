// import '../../../models/class_model.dart';

// class CharacterSheetState {
//   // Core Character Info
//   final String characterName;
//   final String race;
//   final String alignment;
//   final String background;
//   final String imagePath;

//   // Class & Level Info
//   final Map<DndClass, int> characterClasses;

//   // Calculated Stats
//   final Map<String, int> abilityScores;
//   final Map<String, int> abilityModifiers;
//   final int proficiencyBonus;
//   final int hitPoints;
//   final int armorClass;
//   final int initiative;
//   final int speed;

//   // Skills
//   final Map<String, int> skillBonuses;

//   // Features
//   final List<ClassFeature> features;

//   // Biography
//   final String personalityTraits;
//   final String ideals;
//   final String bonds;
//   final String flaws;

//   const CharacterSheetState({
//     this.characterName = '',
//     this.race = '',
//     this.alignment = '',
//     this.background = '',
//     this.imagePath = '',
//     this.characterClasses = const {},
//     this.abilityScores = const {},
//     this.abilityModifiers = const {},
//     this.proficiencyBonus = 0,
//     this.hitPoints = 0,
//     this.armorClass = 0,
//     this.initiative = 0,
//     this.speed = 30,
//     this.skillBonuses = const {},
//     this.features = const [],
//     this.personalityTraits = '',
//     this.ideals = '',
//     this.bonds = '',
//     this.flaws = '',
//   });

//   int get totalLevel =>
//       characterClasses.values.fold(0, (prev, level) => prev + level);

//   String get classLevelDisplay {
//     return characterClasses.entries
//         .map((e) => '${e.key.name} ${e.value}')
//         .join(' / ');
//   }

//   CharacterSheetState copyWith({
//     Map<DndClass, int>? characterClasses,
//     int? hitPoints,
//   }) {
//     return CharacterSheetState(
//       characterName: characterName,
//       race: race,
//       alignment: alignment,
//       background: background,
//       imagePath: imagePath,
//       characterClasses: characterClasses ?? this.characterClasses,
//       abilityScores: abilityScores,
//       abilityModifiers: abilityModifiers,
//       proficiencyBonus: proficiencyBonus,
//       hitPoints: hitPoints ?? this.hitPoints,
//       armorClass: armorClass,
//       initiative: initiative,
//       speed: speed,
//       skillBonuses: skillBonuses,
//       features: features,
//       personalityTraits: personalityTraits,
//       ideals: ideals,
//       bonds: bonds,
//       flaws: flaws,
//     );
//   }
// }

import '../../../models/class_model.dart'; // Adjust import path

// A new simple model for flexible biography entries
class BioEntry {
  final String title;
  final String text;
  const BioEntry({required this.title, required this.text});
}

class CharacterSheetState {
  // Core Character Info
  final String characterName;
  final String race;
  final String alignment;
  final String background;
  final String imagePath;

  // Class & Level Info
  final Map<DndClass, int> characterClasses;

  // Calculated Stats
  final Map<String, int> abilityScores;
  final Map<String, int> abilityModifiers;
  final int proficiencyBonus;
  final int hitPoints;
  final int armorClass;
  final int initiative;
  final int speed;

  // Skills
  Map<String, int> skillBonuses;

  // Features
  List<ClassFeature> features; // Make sure ClassFeature has description

  // Biography (now a flexible list)
  List<BioEntry> biographyEntries;

  CharacterSheetState({
    this.characterName = '',
    this.race = '',
    this.alignment = '',
    this.background = '',
    this.imagePath = '',
    this.characterClasses = const {},
    this.abilityScores = const {},
    this.abilityModifiers = const {},
    this.proficiencyBonus = 0,
    this.hitPoints = 0,
    this.armorClass = 0,
    this.initiative = 0,
    this.speed = 30,
    this.skillBonuses = const {},
    this.features = const [],
    this.biographyEntries = const [], // Updated from individual strings
  });

  int get totalLevel =>
      characterClasses.values.fold(0, (prev, level) => prev + level);

  String get classLevelDisplay {
    return characterClasses.entries
        .map((e) => '${e.key.name} ${e.value}')
        .join(' / ');
  }

  // A comprehensive copyWith for state updates
  CharacterSheetState copyWith({
    String? characterName,
    String? race,
    String? alignment,
    String? background,
    String? imagePath,
    Map<DndClass, int>? characterClasses,
    Map<String, int>? abilityScores,
    Map<String, int>? abilityModifiers,
    int? proficiencyBonus,
    int? hitPoints,
    int? armorClass,
    int? initiative,
    int? speed,
    Map<String, int>? skillBonuses,
    List<ClassFeature>? features,
    List<BioEntry>? biographyEntries,
  }) {
    return CharacterSheetState(
      characterName: characterName ?? this.characterName,
      race: race ?? this.race,
      alignment: alignment ?? this.alignment,
      background: background ?? this.background,
      imagePath: imagePath ?? this.imagePath,
      characterClasses: characterClasses ?? this.characterClasses,
      abilityScores: abilityScores ?? this.abilityScores,
      abilityModifiers: abilityModifiers ?? this.abilityModifiers,
      proficiencyBonus: proficiencyBonus ?? this.proficiencyBonus,
      hitPoints: hitPoints ?? this.hitPoints,
      armorClass: armorClass ?? this.armorClass,
      initiative: initiative ?? this.initiative,
      speed: speed ?? this.speed,
      skillBonuses: skillBonuses ?? this.skillBonuses,
      features: features ?? this.features,
      biographyEntries: biographyEntries ?? this.biographyEntries,
    );
  }
}
