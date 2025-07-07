import 'package:dnd_app_v2/widgets/core/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../models/spell_model.dart';
import '../../../services/app_services/spells_service.dart';

class SpellListViewModel extends BaseViewModel {
  final SpellsService _spellsService = SpellsService.instance;

  List<Spell> _allSpells = [];

  String? _error;

  String _searchQuery = '';

  final Map<String, dynamic> _activeFilters = {};

  bool isSearchVisible = false;

  void toggleSearchVisibility() {
    isSearchVisible = !isSearchVisible;
    notifyListeners();
  }

  void hideSearch() {
    isSearchVisible = false;
    notifyListeners();
  }

  List<Spell> get filteredSpells {
    List<Spell> spells = _allSpells;

    if (_activeFilters.isNotEmpty) {
      spells = spells.where((spell) {
        bool passesLevelFilter = !_activeFilters.containsKey('level') ||
            spell.level == _activeFilters['level'];
        bool passesSchoolFilter = !_activeFilters.containsKey('school') ||
            spell.school == _activeFilters['school'];
        return passesLevelFilter && passesSchoolFilter;
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final lowerCaseQuery = _searchQuery.toLowerCase();
      spells = spells
          .where((spell) => spell.name.toLowerCase().contains(lowerCaseQuery))
          .toList();
    }

    if (_activeFilters.isNotEmpty) {
      spells = spells.where((spell) {
        bool passesLevelFilter = !_activeFilters.containsKey('level') ||
            spell.level == _activeFilters['level'];
        bool passesSchoolFilter = !_activeFilters.containsKey('school') ||
            spell.school == _activeFilters['school'];

        bool passesClassFilter = true; // Default to true
        if (_activeFilters.containsKey('class')) {
          passesClassFilter = spell.classes?.any(
                  (spellClass) => spellClass.name == _activeFilters['class']) ??
              false;
        }
        // -------------------------------------

        return passesLevelFilter && passesSchoolFilter && passesClassFilter;
      }).toList();
    }

    return spells;
  }

  String? get error => _error;

  Map<String, dynamic> get activeFilters => _activeFilters;

  List<int> get availableLevels =>
      _allSpells.map((s) => s.level).toSet().toList()..sort();

  List<String> get availableSchools =>
      _allSpells.map((s) => s.school).toSet().toList()..sort();

  List<String> get availableClasses {
    final allClassNames = <String>{};

    for (final spell in _allSpells) {
      if (spell.classes != null) {
        for (final spellClass in spell.classes!) {
          allClassNames.add(spellClass.name);
        }
      }
    }

    return allClassNames.toList()..sort();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void applyFilter(String key, dynamic value) {
    _activeFilters[key] = value;
    notifyListeners();
  }

  void removeFilter(String key) {
    _activeFilters.remove(key);
    notifyListeners();
  }

  void clearFilters() {
    _activeFilters.clear();
    notifyListeners();
  }

  Future<void> fetchSpells() async {
    setLoading(true);
    _error = null;
    notifyListeners();

    try {
      await _spellsService.loadSpells();
      _allSpells = _spellsService.spells;
    } catch (e) {
      _error =
          'Failed to load spells. Please check your connection and try again.';
      _allSpells = []; // Ensure list is empty on error
    } finally {
      setLoading(false);
    }
  }

  @override
  void initState(BuildContext context) {
    _allSpells = SpellsService.instance.spells;
  }

  @override
  void resetState() {}
}
