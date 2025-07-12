import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/background_model.dart';
import '../models/character_model.dart';
import '../models/class_model.dart';
import '../models/feat_model.dart';
import '../utils/utils.dart';

class RulesService {
  static RulesService instance = RulesService._();
  RulesService._();

  List<DndClass> _classes = [];
  List<Background> _backgrounds = [];
  List<Feat> _feats = [];

  List<DndClass> get dndClasses => List.unmodifiable(_classes);
  List<Background> get backgrounds => List.unmodifiable(_backgrounds);
  List<Feat> get feats => List.unmodifiable(_feats);

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> loadRules({String baseUrl = 'http://localhost:5000/api'}) async {
    if (_isLoaded) return;

    try {
      final responses = await Future.wait([
        http.get(Uri.parse('$baseUrl/classes')),
        http.get(Uri.parse('$baseUrl/backgrounds')),
        http.get(Uri.parse('$baseUrl/feats')),
      ]);

      if (responses[0].statusCode == 200) {
        _classes = dndClassListFromJson(responses[0].body);
        debugPrint('Successfully loaded ${_classes.length} classes.');
      } else {
        throw Exception('Failed to load classes: ${responses[0].statusCode}');
      }

      if (responses[1].statusCode == 200) {
        final List<dynamic> backgroundJson = json.decode(responses[1].body);
        _backgrounds =
            backgroundJson.map((json) => Background.fromJson(json)).toList();
        debugPrint('Successfully loaded ${_backgrounds.length} backgrounds.');
      } else {
        throw Exception(
            'Failed to load backgrounds: ${responses[1].statusCode}');
      }

      if (responses[2].statusCode == 200) {
        final List<dynamic> featJson = json.decode(responses[2].body);
        _feats = featJson.map((json) => Feat.fromJson(json)).toList();
        debugPrint('Successfully loaded ${_feats.length} feats.');
      } else {
        throw Exception('Failed to load feats: ${responses[2].statusCode}');
      }

      _isLoaded = true;
    } catch (e) {
      debugPrint('An error occurred while loading rules: $e');
      rethrow;
    }
  }

  Character createNewCharacter({
    required String name,
    required String race,
    required DndClass chosenClass,
    required Background chosenBackground,
    required List<AbilityScore> abilityScores,
    required List<String> chosenSkillProficiencies,
  }) {
    int level = 1;
    int proficiencyBonus = getProficiencyBonusForLevel(level);

    int conModifier = abilityScores.firstWhere((s) => s.name == "CON").modifier;
    int maxHp = chosenClass.hd.faces + conModifier;

    List<String> savingThrows = chosenClass.proficiency;
    List<String> skillProficiencies = [
      ...chosenSkillProficiencies,
      ...(chosenBackground.skillProficiencies?.map((p) => p.keys.first) ?? []),
    ];

    return Character(
      name: name,
      race: race,
      mainClass: chosenClass.name,
      background: chosenBackground.name,
      alignment: "Neutral",
      playerName: "Player",
      level: level,
      proficiencyBonus: proficiencyBonus,
      maxHp: maxHp,
      currentHp: maxHp,
      hitDice: "1d${chosenClass.hd.faces}",
      speed: 30,
      vision: "Normal",
      abilityScores: abilityScores.map((score) {
        return AbilityScore(
            name: score.name,
            value: score.value,
            modifier: score.modifier,
            isProficient: savingThrows.contains(score.name));
      }).toList(),
      skills: _calculateAllSkillBonuses(
          [], abilityScores, skillProficiencies, proficiencyBonus),
      features: Utils.instance.classFeatureListToFeatureList(
          getNewFeaturesForLevel(chosenClass.name, null, 1)),
      initiative: abilityScores.firstWhere((s) => s.name == "DEX").modifier,
      armorClass:
          10 + abilityScores.firstWhere((s) => s.name == "DEX").modifier,
      passivePerception: 10 +
          (_calculateSkillBonusForAbility("WIS", "Perception", abilityScores,
              skillProficiencies, proficiencyBonus)),
      weapons: [],
    );
  }

  Character levelUpCharacter(
    Character oldChar, {
    required String classToLevelUp,
    String? chosenSubclass,
    Map<String, dynamic>? asiOrFeatChoice,
  }) {
    final newLevel = oldChar.level + 1;
    final dndClass = _classes.firstWhere((c) => c.name == classToLevelUp);
    final isMulticlassing = !oldChar.mainClass.contains(classToLevelUp);

    if (isMulticlassing && !canMulticlass(oldChar, dndClass)) {
      throw Exception(
          "${oldChar.name} does not meet the requirements to multiclass into ${dndClass.name}.");
    }

    final newProficiencyBonus = getProficiencyBonusForLevel(newLevel);

    final hpGained =
        getHitPointsOnLevelUp(oldChar, classToLevelUp, takeAverage: true);
    final newMaxHp = oldChar.maxHp + hpGained;

    List<AbilityScore> newAbilityScores = List.from(oldChar.abilityScores);
    List<Feature> newFeatures = List.from(oldChar.features);

    final classLevel = _getClassLevel(oldChar.mainClass, classToLevelUp) + 1;
    if (classLevel % 4 == 0 && asiOrFeatChoice != null) {
      if (asiOrFeatChoice['type'] == 'asi') {
        final abilitiesToIncrease =
            List<String>.from(asiOrFeatChoice['abilities']);
        for (var abilityName in abilitiesToIncrease) {
          final index =
              newAbilityScores.indexWhere((s) => s.name == abilityName);
          if (index != -1) {
            final oldScore = newAbilityScores[index];
            newAbilityScores[index] = AbilityScore(
                name: oldScore.name,
                value: oldScore.value + 1,
                modifier: ((oldScore.value + 1 - 10) / 2).floor(),
                isProficient: oldScore.isProficient);
          }
        }
      } else if (asiOrFeatChoice['type'] == 'feat') {
        final feat = _feats.firstWhere((f) => f.name == asiOrFeatChoice['id']);
        newFeatures.add(Feature(
            name: feat.name,
            description:
                feat.entries.map((e) => (e as StringEntry).text).join('\n')));
      }
    }

    newFeatures.addAll(Utils.instance.classFeatureListToFeatureList(
        getNewFeaturesForLevel(dndClass.name, chosenSubclass, classLevel)));

    final updatedCharacter = Character(
      name: oldChar.name,
      race: oldChar.race,
      mainClass: isMulticlassing
          ? "${oldChar.mainClass} / $classToLevelUp 1"
          : _updateClassLevelString(oldChar.mainClass, classToLevelUp),
      background: oldChar.background,
      alignment: oldChar.alignment,
      playerName: oldChar.playerName,
      level: newLevel,
      proficiencyBonus: newProficiencyBonus,
      maxHp: newMaxHp,
      currentHp: oldChar.currentHp + hpGained,
      hitDice: _updateHitDiceString(oldChar.hitDice, dndClass),
      speed: oldChar.speed,
      vision: oldChar.vision,
      abilityScores: newAbilityScores,
      features: newFeatures,
      skills: _calculateAllSkillBonuses(
          oldChar.skills,
          newAbilityScores,
          oldChar.skills
              .where((s) => s.isProficient)
              .map((s) => s.name)
              .toList(),
          newProficiencyBonus),
      initiative: newAbilityScores.firstWhere((s) => s.name == "DEX").modifier,
      armorClass:
          10 + newAbilityScores.firstWhere((s) => s.name == "DEX").modifier,
      passivePerception: 10 +
          _calculateSkillBonusForAbility(
              "WIS",
              "Perception",
              newAbilityScores,
              oldChar.skills
                  .where((s) => s.isProficient)
                  .map((s) => s.name)
                  .toList(),
              newProficiencyBonus),
      weapons: oldChar.weapons,
    );

    return updatedCharacter;
  }

  int getProficiencyBonusForLevel(int characterLevel) {
    if (characterLevel < 1) return 0;
    return ((characterLevel - 1) / 4).floor() + 2;
  }

  int getHitPointsOnLevelUp(Character character, String classToLevelUp,
      {bool takeAverage = true}) {
    final dndClass = _classes.firstWhere((c) => c.name == classToLevelUp);
    final conModifier =
        character.abilityScores.firstWhere((s) => s.name == "CON").modifier;

    if (takeAverage) {
      final averageHp = (dndClass.hd.faces / 2) + 1;
      return averageHp.toInt() + conModifier;
    } else {
      return Random().nextInt(dndClass.hd.faces) + 1 + conModifier;
    }
  }

  bool canMulticlass(Character character, DndClass newClass) {
    if (newClass.multiclassing.requirements.isEmpty) return true;

    for (var requirement in newClass.multiclassing.requirements.entries) {
      final abilityName = requirement.key.toUpperCase();
      final requiredScore = requirement.value;
      final characterScore = character.abilityScores
          .firstWhere((s) => s.name == abilityName)
          .value;

      if (characterScore < requiredScore) return false;
    }
    return true;
  }

  List<Feat> getAvailableFeats(Character character) {
    return feats.where((feat) {
      if (feat.prerequisite == null || feat.prerequisite!.isEmpty) return true;

      return character.level >= 4;
    }).toList();
  }

  List<ClassFeature> getNewFeaturesForLevel(
      String className, String? subclassName, int classLevel) {
    final dndClass = _classes.firstWhere((c) => c.name == className);
    List<ClassFeature> newFeatures = [];

    newFeatures.addAll(dndClass.features.where((f) => f.level == classLevel));

    if (subclassName != null && classLevel >= 3) {
      final subclass =
          dndClass.subclasses.firstWhere((sc) => sc.name == subclassName);
      final subclassFeatureNames = subclass.subclassFeatures
          .where((ref) => int.parse(ref.split('|').last) == classLevel)
          .map((ref) => ref.split('|')[0])
          .toSet();

      if (subclassFeatureNames.isNotEmpty) {
        newFeatures.addAll(dndClass.features.where((f) =>
            subclassFeatureNames.contains(f.name) && f.level == classLevel));
      }
    }
    return newFeatures;
  }

  int _calculateSkillBonusForAbility(
      String abilityName,
      String skillName,
      List<AbilityScore> scores,
      List<String> proficientSkills,
      int proficiencyBonus) {
    final abilityModifier =
        scores.firstWhere((s) => s.name == abilityName.toUpperCase()).modifier;
    final isProficient = proficientSkills.contains(skillName);
    return abilityModifier + (isProficient ? proficiencyBonus : 0);
  }

  List<Skill> _calculateAllSkillBonuses(
      List<Skill> oldSkills,
      List<AbilityScore> scores,
      List<String> proficientSkills,
      int proficiencyBonus) {
    const Map<String, String> allSkillsMap = {
      "Acrobatics": "DEX",
      "Animal Handling": "WIS",
      "Arcana": "INT",
      "Athletics": "STR",
      "Deception": "CHA",
      "History": "INT",
      "Insight": "WIS",
      "Intimidation": "CHA",
      "Investigation": "INT",
      "Medicine": "WIS",
      "Nature": "INT",
      "Perception": "WIS",
      "Performance": "CHA",
      "Persuasion": "CHA",
      "Religion": "INT",
      "Sleight of Hand": "DEX",
      "Stealth": "DEX",
      "Survival": "WIS"
    };

    return allSkillsMap.entries.map((entry) {
      final skillName = entry.key;
      final abilityName = entry.value;
      return Skill(
          name: skillName,
          ability: abilityName,
          isProficient: proficientSkills.contains(skillName),
          bonus: _calculateSkillBonusForAbility(abilityName, skillName, scores,
              proficientSkills, proficiencyBonus));
    }).toList();
  }

  int _getClassLevel(String classString, String classToFind) {
    final classes = classString.split(' / ');
    final classEntry =
        classes.firstWhere((c) => c.startsWith(classToFind), orElse: () => '');
    if (classEntry.isEmpty) return 0;
    return int.parse(classEntry.split(' ').last);
  }

  String _updateClassLevelString(String oldClassString, String classToLevelUp) {
    final classes = oldClassString.split(' / ').map((c) => c.trim()).toList();
    final classIndex = classes.indexWhere((c) => c.startsWith(classToLevelUp));
    final oldLevel = int.parse(classes[classIndex].split(' ').last);
    classes[classIndex] = "$classToLevelUp ${oldLevel + 1}";
    return classes.join(' / ');
  }

  String _updateHitDiceString(String oldHitDice, DndClass newClassDie) {
    return "$oldHitDice, 1d${newClassDie.hd.faces}";
  }
}
