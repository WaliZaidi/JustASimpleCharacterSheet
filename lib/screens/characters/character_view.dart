import 'package:dnd_app_v2/widgets/core/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/state_service.dart';

class CharactersView extends ConsumerStatefulWidget {
  const CharactersView({super.key});

  @override
  ConsumerState<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends ConsumerState<CharactersView> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(StateService.characterListProvider);

    return Scaffold(
      drawer: const AppNavDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                character.characterName,
                style: const TextStyle(shadows: [Shadow(blurRadius: 8)]),
              ),
              background: _CharacterHeader(controller: character),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                child: Text(
                  pageTitles[_selectedIndex],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: pages[_selectedIndex],
          ),
        ],
      ),
      floatingActionButton: _buildFab(context, controller),
    );
  }
}
