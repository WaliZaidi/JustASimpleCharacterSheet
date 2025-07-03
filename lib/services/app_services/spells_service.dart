import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/spell_model.dart';

class SpellsService {
  static SpellsService instance = SpellsService._();
  SpellsService._();

  List<Spell> _spells = [];

  List<Spell> get spells => List.unmodifiable(_spells);

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> loadSpells() async {
    if (_isLoaded) return;

    try {
      final url = Uri.parse('http://localhost:5000/api/spells');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        _spells = spellListFromJson(response.body);
        _isLoaded = true;
        debugPrint('Successfully loaded ${_spells.length} spells.');
      } else {
        throw Exception('Failed to load spells: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('$e');

      rethrow;
    }
  }
}
