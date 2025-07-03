import 'package:dnd_app_v2/services/app_services/spells_service.dart';

class ApiService {
  static ApiService instance = ApiService._();

  ApiService._();

  initialiseAPI() async {
    await SpellsService.instance.loadSpells();
  }
}
