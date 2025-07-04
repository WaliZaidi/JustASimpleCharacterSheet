// // lib/views/spell_list_view.dart

// import 'package:dnd_app_v2/screens/spells/widgets/spell_list_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../models/spell_model.dart';
// import '../../../services/state_service.dart';
// import 'spell_list_vm.dart';

// class SpellListView extends ConsumerWidget {
//   const SpellListView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final viewModel = ref.watch(StateService.spellListProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Spells'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () =>
//                 ref.read(StateService.spellListProvider).fetchSpells(),
//           ),
//         ],
//       ),
//       body: _buildBody(context, ref, viewModel),
//     );
//   }

//   Widget _buildBody(
//       BuildContext context, WidgetRef ref, SpellListViewModel viewModel) {
//     if (viewModel.isLoading && viewModel.spells.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (viewModel.error != null) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 viewModel.error!, // Use the error message from the ViewModel
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Theme.of(context).colorScheme.error),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () =>
//                     ref.read(StateService.spellListProvider).fetchSpells(),
//                 child: const Text('Retry'),
//               )
//             ],
//           ),
//         ),
//       );
//     }

//     if (viewModel.spells.isEmpty) {
//       return const Center(child: Text('No spells found.'));
//     }

//     return RefreshIndicator(
//       onRefresh: () => ref.read(StateService.spellListProvider).fetchSpells(),
//       child: ListView.builder(
//         itemCount: viewModel.spells.length,
//         itemBuilder: (context, index) {
//           final Spell spell = viewModel.spells[index];
//           return SpellListCard(spell: spell);
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Assuming these are defined elsewhere
// import '../../../services/state_service.dart';
// import '../widgets/spell_list_card.dart';
// import 'spell_list_vm.dart';

// class SpellListView extends ConsumerStatefulWidget {
//   const SpellListView({super.key});

//   @override
//   ConsumerState<SpellListView> createState() => _SpellListViewState();
// }

// class _SpellListViewState extends ConsumerState<SpellListView> {
//   final _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _showFilterDialog() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Filter button tapped!')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final viewModelNotifier = ref.read(StateService.spellListProvider.notifier);
//     final viewModel = ref.watch(StateService.spellListProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Spells'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: _showFilterDialog,
//           ),
//         ],
//       ),
//       body: _buildBody(context, viewModel, viewModelNotifier),
//     );
//   }

//   Widget _buildBody(BuildContext context, SpellListViewModel viewModel,
//       SpellListViewModel viewModelNotifier) {
//     if (viewModel.isLoading && viewModel.filteredSpells.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (viewModel.error != null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     // The main body is much cleaner now.
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: TextField(
//             controller: _searchController,
//             onChanged: (query) => viewModelNotifier.search(query),
//             decoration: InputDecoration(
//               hintText: 'Search spells...',
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               suffixIcon: _searchController.text.isNotEmpty
//                   ? IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         _searchController.clear();
//                         viewModelNotifier.search('');
//                       },
//                     )
//                   : null,
//             ),
//           ),
//         ),
//         Expanded(
//           child: viewModel.filteredSpells.isEmpty
//               ? const Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: viewModel.filteredSpells.length,
//                   itemBuilder: (context, index) {
//                     final spell = viewModel.filteredSpells[index];
//                     return SpellListCard(spell: spell);
//                   },
//                 ),
//         ),
//       ],
//     );
//   }
// }

//! MEOW

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/state_service.dart';
import '../../../utils/utils.dart';
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
    final viewModelNotifier = ref.read(StateService.spellListProvider.notifier);
    final viewModel = ref.watch(StateService.spellListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spells'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filters',
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
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
          Expanded(
            child: _buildBodyContent(context, viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, SpellListViewModel viewModel) {
    if (viewModel.isLoading && viewModel.filteredSpells.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(viewModel.error!, textAlign: TextAlign.center),
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

    if (viewModel.filteredSpells.isEmpty) {
      return const Center(child: Text('No spells match your criteria.'));
    }

    return ListView.builder(
      itemCount: viewModel.filteredSpells.length,
      itemBuilder: (context, index) {
        final spell = viewModel.filteredSpells[index];
        return SpellListCard(spell: spell);
      },
    );
  }
}

class _FilterSheet extends ConsumerWidget {
  const _FilterSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(StateService.spellListProvider);
    final viewModelNotifier = ref.read(StateService.spellListProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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

          // Filter for Level
          _FilterDropdown<int>(
            label: 'Level',
            value: viewModel.activeFilters['level'],
            items: viewModel.availableLevels,
            onChanged: (val) {
              if (val == null) {
                viewModelNotifier.removeFilter('level');
              } else {
                viewModelNotifier.applyFilter('level', val);
              }
            },
          ),
          const SizedBox(height: 16),

          // Filter for School
          _FilterDropdown<String>(
            label: 'School',
            value: viewModel.activeFilters['school'],
            items: viewModel.availableSchools,
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _FilterDropdown<T> extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemTextBuilder,
  });

  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T)? itemTextBuilder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: value != null
            ? IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () => onChanged(null),
              )
            : null,
      ),
      items: items.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(itemTextBuilder != null
              ? itemTextBuilder!(item)
              : item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
