import 'dart:convert';

// --- Top-Level Parsing ---
List<DndClass> dndClassListFromJson(String str) =>
    List<DndClass>.from(json.decode(str).map((x) => DndClass.fromJson(x)));

// --- Main Class and Subclass Models ---

class DndClass {
  final String name;
  final String source;
  final int page;
  final List<OtherSource> otherSources;
  final HitDice hd;
  final List<String> proficiency;
  final String? spellcastingAbility;
  final List<int> cantripProgression;
  final List<OptionalFeatureProgression> optionalfeatureProgression;
  final StartingProficiencies startingProficiencies;
  final StartingEquipment startingEquipment;
  final Multiclassing multiclassing;
  final List<ClassTableGroup> classTableGroups;
  final List<ClassFeatureReference> classFeatures;
  final String subclassTitle;
  final bool? hasFluff;
  final bool? hasFluffImages;

  // --- Enriched Data (from your Python script) ---
  final List<Subclass> subclasses;
  final List<ClassFeature> features;
  final List<ClassFluff>? fluff;

  DndClass({
    required this.name,
    required this.source,
    required this.page,
    required this.otherSources,
    required this.hd,
    required this.proficiency,
    this.spellcastingAbility,
    required this.cantripProgression,
    required this.optionalfeatureProgression,
    required this.startingProficiencies,
    required this.startingEquipment,
    required this.multiclassing,
    required this.classTableGroups,
    required this.classFeatures,
    required this.subclassTitle,
    this.hasFluff,
    this.hasFluffImages,
    required this.subclasses,
    required this.features,
    this.fluff,
  });

  factory DndClass.fromJson(Map<String, dynamic> json) => DndClass(
        name: json["name"],
        source: json["source"],
        page: _parseInt(json["page"])!,
        otherSources: json["otherSources"] == null
            ? []
            : List<OtherSource>.from(
                json["otherSources"].map((x) => OtherSource.fromJson(x))),
        hd: HitDice.fromJson(json["hd"]),
        proficiency: List<String>.from(json["proficiency"].map((x) => x)),
        spellcastingAbility: json["spellcastingAbility"],
        cantripProgression:
            List<int>.from(json["cantripProgression"].map((x) => x)),
        optionalfeatureProgression: List<OptionalFeatureProgression>.from(
            json["optionalfeatureProgression"]
                .map((x) => OptionalFeatureProgression.fromJson(x))),
        startingProficiencies:
            StartingProficiencies.fromJson(json["startingProficiencies"]),
        startingEquipment:
            StartingEquipment.fromJson(json["startingEquipment"]),
        multiclassing: Multiclassing.fromJson(json["multiclassing"]),
        classTableGroups: List<ClassTableGroup>.from(
            json["classTableGroups"].map((x) => ClassTableGroup.fromJson(x))),
        classFeatures: _parseClassFeatureReferences(json["classFeatures"]),
        subclassTitle: json["subclassTitle"],
        hasFluff: json["hasFluff"],
        hasFluffImages: json["hasFluffImages"],
        subclasses: json["subclasses"] == null
            ? []
            : List<Subclass>.from(
                json["subclasses"].map((x) => Subclass.fromJson(x))),
        features: json["features"] == null
            ? []
            : List<ClassFeature>.from(
                json["features"].map((x) => ClassFeature.fromJson(x))),
        fluff: json["fluff"] == null
            ? null
            : List<ClassFluff>.from(
                json["fluff"].map((x) => ClassFluff.fromJson(x))),
      );
}

class Subclass {
  final String name;
  final String shortName;
  final String source;
  final String className;
  final String classSource;
  final int page;
  final List<AdditionalSpells>? additionalSpells;
  final List<String> subclassFeatures;
  final List<ImageInfo>? images;

  Subclass({
    required this.name,
    required this.shortName,
    required this.source,
    required this.className,
    required this.classSource,
    required this.page,
    this.additionalSpells,
    required this.subclassFeatures,
    this.images,
  });

  factory Subclass.fromJson(Map<String, dynamic> json) => Subclass(
        name: json["name"],
        shortName: json["shortName"],
        source: json["source"],
        className: json["className"],
        classSource: json["classSource"],
        page: _parseInt(json["page"])!,
        additionalSpells: json["additionalSpells"] == null
            ? null
            : List<AdditionalSpells>.from(json["additionalSpells"]
                .map((x) => AdditionalSpells.fromJson(x))),
        subclassFeatures:
            List<String>.from(json["subclassFeatures"].map((x) => x)),
        images: json["images"] == null
            ? null
            : List<ImageInfo>.from(
                json["images"].map((x) => ImageInfo.fromJson(x))),
      );
}

class ClassFeature {
  final String name;
  final String source;
  final int level;
  final List<Entry> entries;

  ClassFeature({
    required this.name,
    required this.source,
    required this.level,
    required this.entries,
  });

  factory ClassFeature.fromJson(Map<String, dynamic> json) => ClassFeature(
        name: json["name"],
        source: json["source"],
        level: json["level"],
        entries: _parseEntries(json["entries"]),
      );
}

class ClassFluff {
  final String name;
  final String source;
  final List<Entry> entries;
  final List<ImageInfo>? images;

  ClassFluff(
      {required this.name,
      required this.source,
      required this.entries,
      this.images});

  factory ClassFluff.fromJson(Map<String, dynamic> json) => ClassFluff(
        name: json["name"],
        source: json["source"],
        entries: _parseEntries(json["entries"]),
        images: json["images"] == null
            ? null
            : List<ImageInfo>.from(
                json["images"].map((x) => ImageInfo.fromJson(x))),
      );
}

sealed class Entry {}

class StringEntry extends Entry {
  final String text;
  StringEntry(this.text);
}

class ObjectEntry extends Entry {
  final Map<String, dynamic> data;
  ObjectEntry(this.data);
}

class OtherSource {
  final String source;
  final int page;
  OtherSource({required this.source, required this.page});
  factory OtherSource.fromJson(Map<String, dynamic> json) =>
      OtherSource(source: json["source"], page: _parseInt(json["page"])!);
}

class HitDice {
  final int number;
  final int faces;
  HitDice({required this.number, required this.faces});
  factory HitDice.fromJson(Map<String, dynamic> json) => HitDice(
      number: _parseInt(json["number"])!, faces: _parseInt(json["faces"])!);
}

class OptionalFeatureProgression {
  final String name;
  final List<String> featureType;
  final List<int> progression;

  OptionalFeatureProgression(
      {required this.name,
      required this.featureType,
      required this.progression});

  factory OptionalFeatureProgression.fromJson(Map<String, dynamic> json) =>
      OptionalFeatureProgression(
        name: json["name"],
        featureType: List<String>.from(json["featureType"].map((x) => x)),
        progression: List<int>.from(json["progression"].map((x) => x)),
      );
}

class StartingProficiencies {
  final List<String>? armor;
  final List<dynamic>? weapons;
  final List<String>? tools;
  final List<Choose>? skills;

  StartingProficiencies({this.armor, this.weapons, this.tools, this.skills});

  factory StartingProficiencies.fromJson(Map<String, dynamic> json) =>
      StartingProficiencies(
        armor: json["armor"] == null
            ? null
            : List<String>.from(json["armor"].map((x) => x)),
        weapons: json["weapons"] == null
            ? null
            : List<dynamic>.from(json["weapons"].map((x) => x)),
        tools: json["tools"] == null
            ? null
            : List<String>.from(json["tools"].map((x) => x)),
        skills: json["skills"] == null
            ? null
            : List<Choose>.from(json["skills"].map((x) => Choose.fromJson(x))),
      );
}

class Choose {
  final List<String> from;
  final int count;
  Choose({required this.from, required this.count});

  factory Choose.fromJson(Map<String, dynamic> json) {
    final innerMap = json['choose'] as Map<String, dynamic>;
    return Choose(
      from: List<String>.from(innerMap["from"].map((x) => x)),
      count: _parseInt(innerMap["count"])!,
    );
  }
}

class StartingEquipment {
  final bool additionalFromBackground;
  final List<String> defaultValue;
  final String goldAlternative;

  StartingEquipment(
      {required this.additionalFromBackground,
      required this.defaultValue,
      required this.goldAlternative});

  factory StartingEquipment.fromJson(Map<String, dynamic> json) =>
      StartingEquipment(
        additionalFromBackground: json["additionalFromBackground"],
        defaultValue: List<String>.from(json["default"].map((x) => x)),
        goldAlternative: json["goldAlternative"],
      );
}

class Multiclassing {
  final Map<String, int> requirements;
  final ProficienciesGained proficienciesGained;

  Multiclassing(
      {required this.requirements, required this.proficienciesGained});

  factory Multiclassing.fromJson(Map<String, dynamic> json) => Multiclassing(
        requirements: Map<String, int>.from(json["requirements"]),
        proficienciesGained:
            ProficienciesGained.fromJson(json["proficienciesGained"]),
      );
}

class ProficienciesGained {
  final List<String>? armor;
  final List<String>? tools;
  ProficienciesGained({this.armor, this.tools});
  factory ProficienciesGained.fromJson(Map<String, dynamic> json) =>
      ProficienciesGained(
        armor: json["armor"] == null
            ? null
            : List<String>.from(json["armor"].map((x) => x)),
        tools: json["tools"] == null
            ? null
            : List<String>.from(json["tools"].map((x) => x)),
      );
}

class ClassTableGroup {
  final String? title;
  final List<String> colLabels;
  final List<List<int>>? rows;
  final List<List<int>>? rowsSpellProgression;

  ClassTableGroup(
      {this.title,
      required this.colLabels,
      this.rows,
      this.rowsSpellProgression});

  factory ClassTableGroup.fromJson(Map<String, dynamic> json) =>
      ClassTableGroup(
        title: json["title"],
        colLabels: List<String>.from(json["colLabels"].map((x) => x)),
        rows: json["rows"] == null
            ? null
            : List<List<int>>.from(json["rows"]
                .map((x) => List<int>.from(x.map((y) => _parseInt(y)!)))),
        rowsSpellProgression: json["rowsSpellProgression"] == null
            ? null
            : List<List<int>>.from(json["rowsSpellProgression"]
                .map((x) => List<int>.from(x.map((y) => _parseInt(y)!)))),
      );
}

class AdditionalSpells {
  final Map<String, List<String>> prepared;
  AdditionalSpells({required this.prepared});

  factory AdditionalSpells.fromJson(Map<String, dynamic> json) =>
      AdditionalSpells(
        prepared: Map.from(json["prepared"]).map(
          (k, v) => MapEntry(k, List<String>.from(v.map((x) => x))),
        ),
      );
}

class ImageInfo {
  final String type;
  final ImageHref href;
  final int? width;
  final int? height;
  ImageInfo({required this.type, required this.href, this.width, this.height});
  factory ImageInfo.fromJson(Map<String, dynamic> json) => ImageInfo(
        type: json["type"],
        href: ImageHref.fromJson(json["href"]),
        width: _parseInt(json["width"]),
        height: _parseInt(json["height"]),
      );
}

class ImageHref {
  final String type;
  final String path;
  ImageHref({required this.type, required this.path});
  factory ImageHref.fromJson(Map<String, dynamic> json) => ImageHref(
        type: json["type"],
        path: json["path"],
      );
}

sealed class ClassFeatureReference {}

class StringFeatureReference extends ClassFeatureReference {
  final String reference;
  StringFeatureReference(this.reference);
}

class ObjectFeatureReference extends ClassFeatureReference {
  final String classFeature;
  final bool? gainSubclassFeature;
  ObjectFeatureReference(
      {required this.classFeature, this.gainSubclassFeature});
  factory ObjectFeatureReference.fromJson(Map<String, dynamic> json) =>
      ObjectFeatureReference(
          classFeature: json["classFeature"],
          gainSubclassFeature: json["gainSubclassFeature"]);
}

// --- Universal Parsing Helpers ---
int? _parseInt(dynamic jsonValue) {
  if (jsonValue == null) return null;
  if (jsonValue is int) return jsonValue;
  if (jsonValue is String) return int.tryParse(jsonValue);
  if (jsonValue is Map) {
    if (jsonValue.containsKey('\$numberInt')) {
      return int.tryParse(jsonValue['\$numberInt'].toString());
    }
  }
  return null;
}

List<Entry> _parseEntries(List<dynamic>? entriesList) {
  if (entriesList == null) return [];
  return entriesList.map((e) {
    if (e is String) return StringEntry(e);
    if (e is Map<String, dynamic>) return ObjectEntry(e);
    return ObjectEntry({'unparsed': e.toString()});
  }).toList();
}

List<ClassFeatureReference> _parseClassFeatureReferences(
    List<dynamic>? featureList) {
  if (featureList == null) return [];
  return featureList.map((e) {
    if (e is String) return StringFeatureReference(e);
    if (e is Map<String, dynamic>) return ObjectFeatureReference.fromJson(e);
    return StringFeatureReference("Unknown Feature Type: ${e.toString()}");
  }).toList();
}
