import 'package:dnd_app_v2/widgets/core/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../models/spell_model.dart';
import '../../../services/app_services/spells_service.dart';

class SpellListViewModel extends BaseViewModel {
  final SpellsService _spellsService = SpellsService.instance;

  List<Spell> _spells = SpellsService.instance.spells;
  String? _error;

  List<Spell> get spells => _spells;
  String? get error => _error;

  Future<void> fetchSpells() async {
    setLoading(true);
    _error = null;
    notifyListeners();

    try {
      await _spellsService.loadSpells();
      _spells = _spellsService.spells;
    } catch (e) {
      _error =
          'Failed to load spells. Please check your connection and try again.';
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void resetState() {}
}
