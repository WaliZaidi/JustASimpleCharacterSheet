import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/background_model.dart';

class BackgroundService {
  static final BackgroundService _instance = BackgroundService._internal();
  factory BackgroundService() => _instance;
  BackgroundService._internal();

  List<Background> _backgrounds = [];
  List<Background> get backgrounds => List.unmodifiable(_backgrounds);

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> loadBackgrounds() async {
    if (_isLoaded) return;

    try {
      final url = Uri.parse('https://your-api.com/data/backgrounds');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _backgrounds =
            jsonData.map((json) => Background.fromJson(json)).toList();
        _isLoaded = true;
        debugPrint('Successfully loaded ${_backgrounds.length} backgrounds.');
      } else {
        throw Exception('Failed to load backgrounds: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
