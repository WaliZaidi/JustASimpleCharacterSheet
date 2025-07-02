import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import '../../screens/characters/characters_view.dart';
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
          builder: (context, state) => const CharactersView(),
        ),
      ]);
});
