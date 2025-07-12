import 'package:dnd_app_v2/screens/characters/character_sheet_page/character_sheet_page.dart';
import 'package:dnd_app_v2/screens/spells/spell_list/spell_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

final container = ProviderContainer();

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routerConfiuration = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RouteNames.instance.characterList,
      routes: [
        GoRoute(
          path: RouteNames.instance.characterList,
          name: RouteNames.instance.characterList,
          builder: (context, state) => const CharacterSheetScreen(),
        ),
        GoRoute(
          path: RouteNames.instance.spellsList,
          name: RouteNames.instance.spellsList,
          builder: (context, state) => const SpellListView(),
        ),
        GoRoute(
          path: RouteNames.instance.features,
          name: RouteNames.instance.features,
          builder: (context, state) => const FeaturesView(),
        ),
        GoRoute(
          path: RouteNames.instance.biography,
          name: RouteNames.instance.biography,
          builder: (context, state) => const BiblographyView(),
        ),
        GoRoute(
          path: RouteNames.instance.combatInfo,
          name: RouteNames.instance.combatInfo,
          builder: (context, state) => const CombatInfoView(),
        ),
      ]);
});
