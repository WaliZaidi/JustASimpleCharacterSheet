import 'shared_models.dart'; // Import the shared models
import 'dart:convert';

Background backgroundFromJson(String str) =>
    Background.fromJson(json.decode(str));

class Background {
  final String name;
  final String source;
  final int page;
  final bool? srd;
  final bool? basicRules;
  final List<String>? reprintedAs;
  final List<Entry> entries;
  final List<AdditionalSpells>? additionalSpells;

  // These fields have highly variable structures, so using a flexible type is best.
  final List<Map<String, dynamic>>? skillProficiencies;
  final List<Map<String, dynamic>>? languageProficiencies;
  final List<Map<String, dynamic>>? toolProficiencies;
  final List<Map<String, dynamic>>? startingEquipment;
  final List<ImageInfo>? images; // Enriched from fluff file

  Background({
    required this.name,
    required this.source,
    required this.page,
    required this.entries,
    this.srd,
    this.basicRules,
    this.reprintedAs,
    this.skillProficiencies,
    this.languageProficiencies,
    this.toolProficiencies,
    this.startingEquipment,
    this.additionalSpells,
    this.images,
  });

  factory Background.fromJson(Map<String, dynamic> json) {
    return Background(
      name: json["name"],
      source: json["source"],
      page: parseInt(json["page"])!,
      srd: json["srd"],
      basicRules: json["basicRules"],
      reprintedAs: json["reprintedAs"] == null
          ? null
          : List<String>.from(json["reprintedAs"]),
      entries: Entry.fromJsonList(json["entries"]),
      additionalSpells: json["additionalSpells"] == null
          ? null
          : List<AdditionalSpells>.from(json["additionalSpells"]
              .map((x) => AdditionalSpells.fromJson(x))),
      skillProficiencies: json["skillProficiencies"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["skillProficiencies"]),
      languageProficiencies: json["languageProficiencies"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["languageProficiencies"]),
      toolProficiencies: json["toolProficiencies"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["toolProficiencies"]),
      startingEquipment: json["startingEquipment"] == null
          ? null
          : List<Map<String, dynamic>>.from(json["startingEquipment"]),
      images: json["images"] == null
          ? null
          : List<ImageInfo>.from(
              json["images"].map((x) => ImageInfo.fromJson(x))),
    );
  }
}
