// lib/views/spell_list_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/spell_model.dart';
import '../../../services/state_service.dart';
import 'spell_list_vm.dart';

class SpellListView extends ConsumerWidget {
  const SpellListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(StateService.spellListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spells'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(StateService.spellListProvider).fetchSpells(),
          ),
        ],
      ),
      body: _buildBody(context, ref, viewModel),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, SpellListViewModel viewModel) {
    if (viewModel.isLoading && viewModel.spells.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.error!, // Use the error message from the ViewModel
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    ref.read(StateService.spellListProvider).fetchSpells(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      );
    }

    if (viewModel.spells.isEmpty) {
      return const Center(child: Text('No spells found.'));
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(StateService.spellListProvider).fetchSpells(),
      child: ListView.builder(
        itemCount: viewModel.spells.length,
        itemBuilder: (context, index) {
          final Spell spell = viewModel.spells[index];
          return ListTile(
            title: Text(spell.name),
            subtitle: Text('Level ${spell.level} ${spell.school}'),
            trailing: Text(spell.source,
                style: Theme.of(context).textTheme.bodySmall),
            onTap: () {
              //todo: Lets add something here more
            },
          );
        },
      ),
    );
  }
}
