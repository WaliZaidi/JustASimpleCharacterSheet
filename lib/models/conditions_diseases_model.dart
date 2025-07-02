import 'shared_models.dart';
import 'dart:convert';

Condition conditionFromJson(String str) => Condition.fromJson(json.decode(str));

class Condition {
  final String name;
  final String source;
  final int? page;
  final List<Entry> entries;
  final List<ImageInfo>? images;
  final List<String>? reprintedAs;

  Condition({
    required this.name,
    required this.source,
    this.page,
    required this.entries,
    this.images,
    this.reprintedAs,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        name: json["name"],
        source: json["source"],
        page: parseInt(json["page"]),
        entries: Entry.fromJsonList(json["entries"]),
        images: json["images"] == null
            ? null
            : List<ImageInfo>.from(
                json["images"].map((x) => ImageInfo.fromJson(x))),
        reprintedAs: json["reprintedAs"] == null
            ? null
            : List<String>.from(json["reprintedAs"]),
      );
}
