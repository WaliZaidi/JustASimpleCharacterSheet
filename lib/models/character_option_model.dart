import 'shared_models.dart';
import 'dart:convert';

CharOption charOptionFromJson(String str) =>
    CharOption.fromJson(json.decode(str));

class CharOption {
  final String name;
  final String source;
  final int? page;
  final List<Entry> entries;
  final List<ImageInfo>? images;

  CharOption({
    required this.name,
    required this.source,
    this.page,
    required this.entries,
    this.images,
  });

  factory CharOption.fromJson(Map<String, dynamic> json) => CharOption(
        name: json["name"],
        source: json["source"],
        page: parseInt(json["page"]),
        entries: Entry.fromJsonList(json["entries"]),
        images: json["images"] == null
            ? null
            : List<ImageInfo>.from(
                json["images"].map((x) => ImageInfo.fromJson(x))),
      );
}
