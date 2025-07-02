import 'shared_models.dart';
import 'dart:convert';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

class Recipe {
  final String name;
  final String source;
  final List<String> entries;
  final List<ImageInfo>? images;

  Recipe({
    required this.name,
    required this.source,
    required this.entries,
    this.images,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        name: json["name"],
        source: json["source"],
        entries: List<String>.from(json["entries"].map((x) => x)),
        images: json["images"] == null
            ? null
            : List<ImageInfo>.from(
                json["images"].map((x) => ImageInfo.fromJson(x))),
      );
}
