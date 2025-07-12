import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/character_model.dart';
import '../models/class_model.dart';

class Utils {
  static Utils instance = Utils._();

  Utils._();

  Color getLevelColor(int level) {
    switch (level) {
      case 0:
        return Colors.blueGrey.shade400;
      case 1:
        return Colors.teal.shade400;
      case 2:
        return Colors.blue.shade400;
      case 3:
        return Colors.green.shade600;
      case 4:
        return Colors.lime.shade700;
      case 5:
        return Colors.amber.shade700;
      case 6:
        return Colors.orange.shade700;
      case 7:
        return Colors.red.shade600;
      case 8:
        return Colors.pink.shade500;
      case 9:
        return Colors.deepPurple.shade500;
      default:
        return Colors.grey.shade600;
    }
  }

  Color getSchoolColor(String schoolInitial) {
    switch (schoolInitial.toUpperCase()) {
      case 'A':
        return Colors.teal.shade400;
      case 'C':
        return Colors.orange.shade700;
      case 'D':
        return Colors.lightBlue.shade500;
      case 'E':
        return Colors.deepPurple.shade300;
      case 'V':
        return Colors.red.shade700;
      case 'I':
        return Colors.indigo.shade400;
      case 'N':
        return Colors.grey.shade800;
      case 'T':
        return Colors.brown.shade400;
      default:
        return Colors.grey.shade700;
    }
  }

  String getSchoolName(String schoolInitial) {
    switch (schoolInitial.toUpperCase()) {
      case 'E':
        return 'Enchantment';
      case 'C':
        return 'Conjuration';
      case 'I':
        return 'Illusion';
      case 'T':
        return 'Transmutation';
      case 'A':
        return 'Abjuration';
      case 'D':
        return 'Divination';
      case 'N':
        return 'Necromancy';
      case 'V':
        return 'Evocation';
      default:
        return 'Unknown';
    }
  }

  List<Entry> stringToEntries(List<String> text) {
    return text.map((e) => StringEntry(e)).toList();
  }

  Feature classFeatureToFeature(ClassFeature classFeature) {
    final descriptionBuilder = StringBuffer();

    for (final entry in classFeature.entries) {
      if (entry is StringEntry) {
        descriptionBuilder.writeln(entry.text);
      } else if (entry is ObjectEntry) {
        final prettyJson =
            const JsonEncoder.withIndent('  ').convert(entry.data);
        descriptionBuilder.writeln('--- Special Data ---');
        descriptionBuilder.writeln(prettyJson);
        descriptionBuilder.writeln('--------------------');
      }
    }

    final description = descriptionBuilder.toString().trim();

    final lowerCaseDescription = description.toLowerCase();
    final bool hasUses = lowerCaseDescription.contains(' per day') ||
        lowerCaseDescription.contains(' per short rest') ||
        lowerCaseDescription.contains(' per long rest') ||
        lowerCaseDescription.contains('number of times equal to') ||
        (lowerCaseDescription.contains(' use') &&
            !lowerCaseDescription.contains('can use this'));

    return Feature(
      name: classFeature.name,
      description: description,
      hasUses: hasUses,
    );
  }

  ClassFeature featureToClassFeature(
    Feature feature, {
    required String source,
    required int level,
  }) {
    final List<Entry> entries = feature.description
        .split('\n')
        .map((line) => StringEntry(line))
        .toList();

    return ClassFeature(
      name: feature.name,
      source: source,
      level: level,
      entries: entries,
    );
  }

  List<Feature> classFeatureListToFeatureList(
      List<ClassFeature> classFeatures) {
    if (classFeatures.isEmpty) {
      return [];
    }

    return classFeatures
        .map((classFeature) => classFeatureToFeature(classFeature))
        .toList();
  }

  List<ClassFeature> featureListToClassFeatureList(
    List<Feature> features, {
    required String source,
    required int level,
  }) {
    if (features.isEmpty) {
      return [];
    }

    return features
        .map((feature) =>
            featureToClassFeature(feature, source: source, level: level))
        .toList();
  }
}
