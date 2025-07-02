import 'shared_models.dart';
import 'dart:convert';

Feat featFromJson(String str) => Feat.fromJson(json.decode(str));

class Feat {
  final String name;
  final String source;
  final int? page;
  final List<Entry> entries;
  final List<FeatPrerequisite>? prerequisite;
  final List<Map<String, dynamic>>?
      ability; // Flexible for {str: 1} or {choose: ...}
  final List<Map<String, dynamic>>? armorProficiencies;
  final List<Map<String, dynamic>>? weaponProficiencies;
  final List<Map<String, dynamic>>? toolProficiencies;
  final List<ImageInfo>? images; // Enriched from fluff file

  Feat({
    required this.name,
    required this.source,
    this.page,
    required this.entries,
    this.prerequisite,
    this.ability,
    this.armorProficiencies,
    this.weaponProficiencies,
    this.toolProficiencies,
    this.images,
  });

  factory Feat.fromJson(Map<String, dynamic> json) {
    return Feat(
      name: json["name"],
      source: json["source"],
      page: parseInt(json["page"]),
      entries: Entry.fromJsonList(json["entries"]),
      prerequisite: json["prerequisite"] == null
          ? null
          : List<FeatPrerequisite>.from(
              json["prerequisite"].map((x) => FeatPrerequisite.fromJson(x))),
      ability: json["ability"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["ability"]),
      armorProficiencies: json["armorProficiencies"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["armorProficiencies"]),
      weaponProficiencies: json["weaponProficiencies"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["weaponProficiencies"]),
      toolProficiencies: json["toolProficiencies"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["toolProficiencies"]),
      images: json["images"] == null
          ? null
          : List<ImageInfo>.from(
              json["images"].map((x) => ImageInfo.fromJson(x))),
    );
  }
}

class FeatPrerequisite {
  final List<Map<String, dynamic>>? race;
  final int? level;
  final List<Map<String, dynamic>>? ability;
  final List<Map<String, bool>>? proficiency;
  final bool? spellcasting;
  final bool? spellcasting2020;
  final String? other;

  FeatPrerequisite({
    this.race,
    this.level,
    this.ability,
    this.proficiency,
    this.spellcasting,
    this.spellcasting2020,
    this.other,
  });

  factory FeatPrerequisite.fromJson(Map<String, dynamic> json) {
    return FeatPrerequisite(
      race: json["race"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["race"]),
      level: parseInt(json["level"]),
      ability: json["ability"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["ability"]),
      proficiency: json["proficiency"] == null
          ? null
          : List<Map<String, bool>>.from(
              json["proficiency"].map((x) => Map<String, bool>.from(x))),
      spellcasting: json["spellcasting"],
      spellcasting2020: json["spellcasting2020"],
      other: json["other"],
    );
  }
}
