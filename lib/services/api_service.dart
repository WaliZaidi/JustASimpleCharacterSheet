import 'package:dnd_app_v2/services/app_services/characters_service.dart';

class ApiService {
  static ApiService instance = ApiService._();

  ApiService._();

  initialiseAPI() async {
    await CharacterService.instance.initialiseDebugCharacter();
  }
}
