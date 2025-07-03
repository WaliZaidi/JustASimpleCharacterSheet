import 'package:dnd_app_v2/screens/spells/spell_list/spell_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../screens/characters/characters_view.dart';
import 'route_names.dart';

final container = ProviderContainer();

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routerConfiuration = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RouteNames.instance.spellsList,
      routes: [
        GoRoute(
          path: RouteNames.instance.characterList,
          name: RouteNames.instance.characterList,
          builder: (context, state) => const CharactersView(),
        ),
        GoRoute(
          path: RouteNames.instance.spellsList,
          name: RouteNames.instance.spellsList,
          builder: (context, state) => const SpellListView(),
        ),
      ]);
});
