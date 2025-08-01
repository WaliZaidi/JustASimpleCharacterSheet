import 'package:dnd_app_v2/screens/characters/character_sheet_page/character_sheet_view_vm.dart';
import 'package:dnd_app_v2/screens/spells/spell_list/spell_list_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateService {
  static final spellListProvider = ChangeNotifierProvider((ref) {
    return SpellListViewModel();
  });

  static final characterListProvider = ChangeNotifierProvider((ref) {
    return CharacterSheetViewModel();
  });
}
