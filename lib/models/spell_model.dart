//! NYAN
import 'dart:convert';

List<Spell> spellListFromJson(String str) => List<Spell>.from(
    json.decode(str).map((x) => Spell.fromJson(x as Map<String, dynamic>)));

Spell spellFromJson(String str) => Spell.fromJson(json.decode(str));

class Spell {
  final String? id;
  final String name;
  final String source;
  final int page;
  final int level;
  final String school;
  final List<SpellTime> time;
  final SpellRange range;
  final Components components;
  final List<DurationInfo> duration;
  final List<Entry> entries;
  final List<EntriesHigherLevel>? entriesHigherLevel;
  final List<String>? damageInflict;
  final List<String>? conditionInflict;
  final List<String>? savingThrow;
  final List<String>? miscTags;
  final List<String>? areaTags;
  final List<String>? reprintedAs;
  final bool? hasFluffImages;
  final List<SpellImage>? images;
  final List<SpellClass>? classes;

  Spell({
    this.id,
    required this.name,
    required this.source,
    required this.page,
    required this.level,
    required this.school,
    required this.time,
    required this.range,
    required this.components,
    required this.duration,
    required this.entries,
    this.entriesHigherLevel,
    this.damageInflict,
    this.conditionInflict,
    this.savingThrow,
    this.miscTags,
    this.areaTags,
    this.reprintedAs,
    this.hasFluffImages,
    this.images,
    this.classes,
  });

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      id: json["_id"] == null
          ? null
          : (json["_id"] is Map ? json["_id"]["\$oid"] : json["_id"]),
      name: json["name"],
      source: json["source"],
      page: _parseInt(json["page"]) ?? 0,
      level: _parseInt(json["level"]) ?? 0,
      school: json["school"],
      time:
          List<SpellTime>.from(json["time"].map((x) => SpellTime.fromJson(x))),
      range: SpellRange.fromJson(json["range"]),
      components: Components.fromJson(json["components"]),
      duration: List<DurationInfo>.from(
          json["duration"].map((x) => DurationInfo.fromJson(x))),
      entries: _parseEntries(json["entries"]),
      entriesHigherLevel: json["entriesHigherLevel"] == null
          ? null
          : List<EntriesHigherLevel>.from(json["entriesHigherLevel"]!
              .map((x) => EntriesHigherLevel.fromJson(x))),
      damageInflict: json["damageInflict"] == null
          ? null
          : List<String>.from(json["damageInflict"]!.map((x) => x)),
      conditionInflict: json["conditionInflict"] == null
          ? null
          : List<String>.from(json["conditionInflict"]!.map((x) => x)),
      savingThrow: json["savingThrow"] == null
          ? null
          : List<String>.from(json["savingThrow"]!.map((x) => x)),
      miscTags: json["miscTags"] == null
          ? null
          : List<String>.from(json["miscTags"]!.map((x) => x)),
      areaTags: json["areaTags"] == null
          ? null
          : List<String>.from(json["areaTags"]!.map((x) => x)),
      reprintedAs: json["reprintedAs"] == null
          ? null
          : List<String>.from(json["reprintedAs"]!.map((x) => x)),
      hasFluffImages: json["hasFluffImages"],
      images: json["images"] == null
          ? null
          : List<SpellImage>.from(
              json["images"]!.map((x) => SpellImage.fromJson(x))),
      classes: _parseSpellClasses(json['classes']),
    );
  }
}

List<SpellClass>? _parseSpellClasses(dynamic rawJson) {
  if (rawJson == null) {
    return null;
  }
  List<dynamic> classListJson;
  if (rawJson is Map<String, dynamic> && rawJson.containsKey('fromClassList')) {
    classListJson = rawJson['fromClassList'] as List<dynamic>;
  } else if (rawJson is List) {
    classListJson = rawJson;
  } else {
    return null;
  }
  return classListJson
      .map((item) => SpellClass.fromJson(item as Map<String, dynamic>))
      .toList();
}

int? _parseInt(dynamic jsonValue) {
  if (jsonValue == null) return null;
  if (jsonValue is Map) {
    if (jsonValue.containsKey('\$numberInt')) {
      return int.tryParse(jsonValue['\$numberInt'].toString());
    }
    if (jsonValue.containsKey('\$numberLong')) {
      return int.tryParse(jsonValue['\$numberLong'].toString());
    }
  }
  if (jsonValue is int) return jsonValue;
  if (jsonValue is String) return int.tryParse(jsonValue);
  return null;
}

List<Entry> _parseEntries(List<dynamic>? entriesList) {
  if (entriesList == null) return [];
  return entriesList.map((e) {
    if (e is String) {
      return StringEntry(e);
    }
    if (e is Map<String, dynamic>) {
      switch (e['type']) {
        case 'list':
          return ListEntry.fromJson(e);
        case 'table':
          return TableEntry.fromJson(e);
        case 'entries':
          return MapEntry(e);
        default:
          return MapEntry(e);
      }
    }
    return MapEntry({'unparsed': e.toString()});
  }).toList();
}

sealed class Entry {}

class StringEntry extends Entry {
  final String text;
  StringEntry(this.text);
}

class ListEntry extends Entry {
  final String? style;
  final List<String> items;

  ListEntry({this.style, required this.items});

  factory ListEntry.fromJson(Map<String, dynamic> json) {
    return ListEntry(
      style: json["style"],
      items: List<String>.from(json["items"].map((x) => x.toString())),
    );
  }
}

class TableEntry extends Entry {
  final String? caption;
  final List<String> colLabels;
  final List<String>? colStyles;
  final List<List<dynamic>> rows;
  TableEntry({
    this.caption,
    required this.colLabels,
    this.colStyles,
    required this.rows,
  });

  factory TableEntry.fromJson(Map<String, dynamic> json) => TableEntry(
        caption: json["caption"],
        colLabels: List<String>.from(json["colLabels"].map((x) => x)),
        colStyles: json["colStyles"] == null
            ? null
            : List<String>.from(json["colStyles"].map((x) => x)),
        rows: List<List<dynamic>>.from(
            json["rows"].map((x) => List<dynamic>.from(x.map((y) => y)))),
      );
}

class MapEntry extends Entry {
  final Map<String, dynamic> data;
  MapEntry(this.data);
}

class Components {
  final bool? v;
  final bool? s;
  final MaterialComponent? m;

  Components({this.v, this.s, this.m});

  factory Components.fromJson(Map<String, dynamic> json) {
    MaterialComponent? material;
    if (json["m"] != null) {
      if (json["m"] is String) {
        material = MaterialComponent(text: json["m"]);
      } else if (json["m"] is Map) {
        material = MaterialComponent.fromJson(json["m"]);
      }
    }
    return Components(v: json["v"], s: json["s"], m: material);
  }
}

class MaterialComponent {
  final String text;
  final int? cost;
  final bool? consume;

  MaterialComponent({required this.text, this.cost, this.consume});

  factory MaterialComponent.fromJson(Map<String, dynamic> json) {
    final dynamic consumeValue = json['consume'];
    bool finalConsumeValue;

    if (consumeValue is bool) {
      finalConsumeValue = consumeValue;
    } else if (consumeValue is String) {
      finalConsumeValue = consumeValue.toLowerCase() == 'true';
    } else {
      finalConsumeValue = true;
    }

    return MaterialComponent(
      text: json["text"],
      cost: _parseInt(json["cost"]),
      consume: finalConsumeValue,
    );
  }
}

class DurationInfo {
  final String type;
  final DurationDetail? duration;
  final bool? concentration;

  DurationInfo({required this.type, this.duration, this.concentration});

  factory DurationInfo.fromJson(Map<String, dynamic> json) => DurationInfo(
        type: json["type"],
        duration: json["duration"] == null
            ? null
            : DurationDetail.fromJson(json["duration"]),
        concentration: json["concentration"],
      );
}

class DurationDetail {
  final String type;
  final int amount;

  DurationDetail({required this.type, required this.amount});

  factory DurationDetail.fromJson(Map<String, dynamic> json) => DurationDetail(
        type: json["type"],
        amount: _parseInt(json["amount"])!,
      );
}

class EntriesHigherLevel {
  final String type;
  final String? name;
  final List<String> entries;

  EntriesHigherLevel({required this.type, this.name, required this.entries});

  factory EntriesHigherLevel.fromJson(Map<String, dynamic> json) =>
      EntriesHigherLevel(
        type: json["type"],
        name: json["name"],
        entries: List<String>.from(json["entries"].map((x) => x)),
      );
}

class SpellRange {
  final String type;
  final Distance? distance;

  SpellRange({required this.type, this.distance});

  factory SpellRange.fromJson(Map<String, dynamic> json) => SpellRange(
        type: json["type"],
        distance: json["distance"] == null
            ? null
            : Distance.fromJson(json["distance"]),
      );
}

class Distance {
  final String type;
  final int? amount;

  Distance({required this.type, this.amount});

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        type: json["type"],
        amount: _parseInt(json["amount"]),
      );
}

class SpellTime {
  final int number;
  final String unit;

  SpellTime({required this.number, required this.unit});

  factory SpellTime.fromJson(Map<String, dynamic> json) {
    final parsed = _parseInt(json["number"] ?? 0);
    if (parsed == null) {
      throw FormatException("Invalid number in SpellTime: ${json["number"]}");
    }
    return SpellTime(number: parsed, unit: json["unit"]);
  }
}

class SpellImage {
  final String type;
  final ImageHref href;
  final String? credit;
  final String? title;

  SpellImage({required this.type, required this.href, this.credit, this.title});

  factory SpellImage.fromJson(Map<String, dynamic> json) => SpellImage(
        type: json["type"],
        href: ImageHref.fromJson(json["href"]),
        credit: json["credit"],
        title: json["title"],
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

class SpellClass {
  final String name;
  final String source;
  final String? definedInSource;

  SpellClass({required this.name, required this.source, this.definedInSource});

  factory SpellClass.fromJson(Map<String, dynamic> json) => SpellClass(
        name: json["name"],
        source: json["source"],
        definedInSource: json["definedInSource"],
      );
}

extension SpellToJson on Spell {
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "source": source,
        "page": page,
        "level": level,
        "school": school,
        "time": time.map((x) => x.toJson()).toList(),
        "range": range.toJson(),
        "components": components.toJson(),
        "duration": duration.map((x) => x.toJson()).toList(),
        "entries": entries.map((x) => entryToJson(x)).toList(),
        "entriesHigherLevel":
            entriesHigherLevel?.map((x) => x.toJson()).toList(),
        "damageInflict": damageInflict,
        "conditionInflict": conditionInflict,
        "savingThrow": savingThrow,
        "miscTags": miscTags,
        "areaTags": areaTags,
        "reprintedAs": reprintedAs,
        "hasFluffImages": hasFluffImages,
        "images": images?.map((x) => x.toJson()).toList(),
        "classes": classes?.map((x) => x.toJson()).toList(),
      };
}

dynamic entryToJson(Entry entry) {
  if (entry is StringEntry) {
    return entry.text;
  } else if (entry is ListEntry) {
    return {
      "type": "list",
      "style": entry.style,
      "items": entry.items,
    };
  } else if (entry is TableEntry) {
    return {
      "type": "table",
      "caption": entry.caption,
      "colLabels": entry.colLabels,
      "colStyles": entry.colStyles,
      "rows": entry.rows,
    };
  } else if (entry is MapEntry) {
    return entry.data;
  } else {
    return {'unparsed': entry.toString()};
  }
}

extension SpellTimeToJson on SpellTime {
  Map<String, dynamic> toJson() => {
        "number": number,
        "unit": unit,
      };
}

extension SpellRangeToJson on SpellRange {
  Map<String, dynamic> toJson() => {
        "type": type,
        "distance": distance?.toJson(),
      };
}

extension DistanceToJson on Distance {
  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
      };
}

extension ComponentsToJson on Components {
  Map<String, dynamic> toJson() => {
        "v": v,
        "s": s,
        "m": m?.toJson(),
      };
}

extension MaterialComponentToJson on MaterialComponent {
  Map<String, dynamic> toJson() => {
        "text": text,
        "cost": cost,
      };
}

extension DurationInfoToJson on DurationInfo {
  Map<String, dynamic> toJson() => {
        "type": type,
        "duration": duration?.toJson(),
        "concentration": concentration,
      };
}

extension DurationDetailToJson on DurationDetail {
  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
      };
}

extension EntriesHigherLevelToJson on EntriesHigherLevel {
  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "entries": entries,
      };
}

extension SpellImageToJson on SpellImage {
  Map<String, dynamic> toJson() => {
        "type": type,
        "href": href.toJson(),
        "credit": credit,
        "title": title,
      };
}

extension ImageHrefToJson on ImageHref {
  Map<String, dynamic> toJson() => {
        "type": type,
        "path": path,
      };
}

extension SpellClassToJson on SpellClass {
  Map<String, dynamic> toJson() => {
        "name": name,
        "source": source,
        "definedInSource": definedInSource,
      };
}
