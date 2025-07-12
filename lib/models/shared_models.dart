int? parseInt(dynamic jsonValue) {
  if (jsonValue == null) return null;
  if (jsonValue is int) return jsonValue;
  if (jsonValue is String) return int.tryParse(jsonValue);
  if (jsonValue is Map && jsonValue.containsKey('\$numberInt')) {
    return int.tryParse(jsonValue['\$numberInt'].toString());
  }
  return null;
}

sealed class Entry {
  static List<Entry> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((e) {
      if (e is String) return StringEntry(e);
      if (e is Map<String, dynamic>) return ObjectEntry(e);
      return ObjectEntry({'unparsed': e.toString()});
    }).toList();
  }
}

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
  final int? page;
  OtherSource({required this.source, this.page});

  factory OtherSource.fromJson(Map<String, dynamic> json) =>
      OtherSource(source: json["source"], page: parseInt(json["page"]));
}

class ImageInfo {
  final String type;
  final ImageHref href;
  final String? credit;
  final String? title;

  ImageInfo({required this.type, required this.href, this.credit, this.title});

  factory ImageInfo.fromJson(Map<String, dynamic> json) => ImageInfo(
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

class AdditionalSpells {
  final Map<String, List<String>>? expanded;
  AdditionalSpells({this.expanded});

  factory AdditionalSpells.fromJson(Map<String, dynamic> json) {
    return AdditionalSpells(
      expanded: json["expanded"] == null
          ? null
          : Map.from(json["expanded"]).map(
              (k, v) => MapEntry(k, List<String>.from(v.map((x) => x))),
            ),
    );
  }
}
