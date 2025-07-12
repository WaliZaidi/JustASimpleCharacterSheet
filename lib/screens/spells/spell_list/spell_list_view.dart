import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/state_service.dart';
import '../../../utils/utils.dart';
import '../../../widgets/visual/filter_dropdown.dart';
import '../widgets/spell_list_card.dart';
import 'spell_list_vm.dart';

class SpellListView extends ConsumerStatefulWidget {
  const SpellListView({super.key});

  @override
  ConsumerState<SpellListView> createState() => _SpellListViewState();
}

class _SpellListViewState extends ConsumerState<SpellListView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ref.read(StateService.spellListProvider).initState(context);
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const _FilterSheet());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(StateService.spellListProvider);
    final viewModelNotifier = ref.read(StateService.spellListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spells'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => viewModelNotifier.toggleSearchVisibility(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filters',
            onPressed: () => _showFilterSheet(context),
          ),
        ],
        bottom: viewModel.isSearchVisible
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) => viewModelNotifier.search(query),
                    decoration: InputDecoration(
                      hintText: 'Search spells by name...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                viewModelNotifier.search('');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: _buildBodyContent(context, viewModel),
    );
  }

  Widget _buildBodyContent(
      BuildContext context, SpellListViewModel controller) {
    if (controller.isLoading && controller.filteredSpells.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.error!, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => ref
                    .read(StateService.spellListProvider.notifier)
                    .fetchSpells(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      );
    }

    if (controller.filteredSpells.isEmpty) {
      return const Center(child: Text('No spells match your criteria.'));
    }

    return ListView.builder(
      itemCount: controller.filteredSpells.length,
      itemBuilder: (context, index) {
        final spell = controller.filteredSpells[index];
        return SpellListCard(spell: spell);
      },
    );
  }
}

class _FilterSheet extends ConsumerWidget {
  const _FilterSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(StateService.spellListProvider);
    final viewModelNotifier = ref.read(StateService.spellListProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filters', style: Theme.of(context).textTheme.titleLarge),
              TextButton(
                onPressed: () => viewModelNotifier.clearFilters(),
                child: const Text('Clear All'),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 12),
          FilterDropdown<int>(
            label: 'Level',
            value: controller.activeFilters['level'],
            items: controller.availableLevels,
            onChanged: (val) {
              if (val == null) {
                viewModelNotifier.removeFilter('level');
              } else {
                viewModelNotifier.applyFilter('level', val);
              }
            },
          ),
          const SizedBox(height: 16),
          FilterDropdown<String>(
            label: 'School',
            value: controller.activeFilters['school'],
            items: controller.availableSchools,
            onChanged: (val) {
              if (val == null) {
                viewModelNotifier.removeFilter('school');
              } else {
                viewModelNotifier.applyFilter('school', val);
              }
            },
            itemTextBuilder: (schoolInitial) =>
                Utils.instance.getSchoolName(schoolInitial),
          ),
          const SizedBox(height: 16),
          FilterDropdown<String>(
            label: 'Class',
            items: controller.availableClasses,
            value: controller.activeFilters['class'],
            onChanged: (val) {
              if (val == null) {
                viewModelNotifier.removeFilter('class');
              } else {
                viewModelNotifier.applyFilter('class', val);
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
