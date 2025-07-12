import 'package:dnd_app_v2/models/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/state_service.dart';
import 'character_sheet_state.dart';
import 'character_sheet_view_vm.dart';

// class CharacterSheetScreen extends ConsumerWidget {
//   const CharacterSheetScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // For demonstration purposes without a real provider:

//     // In a real app, you would use this line instead:
//     final controller = ref.watch(StateService.characterListProvider);
//     controller.build();

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 250.0,
//               floating: false,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text(
//                   controller.character.characterName,
//                   style: const TextStyle(shadows: [Shadow(blurRadius: 8)]),
//                 ),
//                 background: _CharacterHeader(controller: controller.character),
//               ),
//               bottom: const TabBar(
//                 tabs: [
//                   Tab(
//                       icon: Icon(Icons.shield_outlined),
//                       text: "Combat & Skills"),
//                   Tab(icon: Icon(Icons.star_outline), text: "Features"),
//                   Tab(icon: Icon(Icons.book_outlined), text: "Biography"),
//                 ],
//               ),
//             ),
//             SliverFillRemaining(
//               child: TabBarView(
//                 children: [
//                   _CoreTab(controller: controller.character),
//                   _FeaturesTab(controller: controller.character),
//                   _BiographyTab(controller: controller.character),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // --- HEADER WIDGET ---
// class _CharacterHeader extends StatelessWidget {
//   final CharacterSheetState controller;
//   const _CharacterHeader({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         // Image.asset(
//         //   controller.imagePath,
//         //   fit: BoxFit.cover,
//         //   color: Colors.black.withOpacity(0.4),
//         //   colorBlendMode: BlendMode.darken,
//         // ),
//         Positioned(
//           bottom: 70,
//           left: 16,
//           right: 16,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 controller.classLevelDisplay,
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     color: Colors.white,
//                     shadows: [const Shadow(blurRadius: 4)]),
//               ),
//               Text(
//                 '${controller.race} • ${controller.background}',
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleMedium
//                     ?.copyWith(color: Colors.white70),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // --- TAB WIDGETS ---
// class _CoreTab extends StatelessWidget {
//   final CharacterSheetState controller;
//   const _CoreTab({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: [
//         // Main Stats (HP, AC, etc.)
//         Wrap(
//           alignment: WrapAlignment.spaceEvenly,
//           runSpacing: 16,
//           children: [
//             _StatDisplay(
//                 label: "Armor Class", value: controller.armorClass.toString()),
//             _StatDisplay(
//                 label: "Hit Points", value: controller.hitPoints.toString()),
//             _StatDisplay(label: "Speed", value: "${controller.speed} ft."),
//             _StatDisplay(
//                 label: "Initiative", value: "+${controller.initiative}"),
//             _StatDisplay(
//                 label: "Proficiency", value: "+${controller.proficiencyBonus}"),
//           ],
//         ),
//         const Divider(height: 32),
//         // Ability Scores
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             childAspectRatio: 0.9,
//             mainAxisSpacing: 8,
//             crossAxisSpacing: 8,
//           ),
//           itemCount: controller.abilityScores.length,
//           itemBuilder: (context, index) {
//             final ability = controller.abilityScores.keys.elementAt(index);
//             return _AbilityScoreCard(
//               ability: ability,
//               score: controller.abilityScores[ability]!,
//               modifier: controller.abilityModifiers[ability]!,
//             );
//           },
//         ),
//         const Divider(height: 32),
//         // Skills
//         Text("Skills", style: Theme.of(context).textTheme.titleLarge),
//         const SizedBox(height: 8),
//         for (var entry in controller.skillBonuses.entries)
//           _SkillRow(skillName: entry.key, bonus: entry.value)
//       ],
//     );
//   }
// }

// class _FeaturesTab extends StatelessWidget {
//   final CharacterSheetState controller;
//   const _FeaturesTab({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemCount: controller.features.length,
//       itemBuilder: (context, index) {
//         final feature = controller.features[index];
//         return Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           child: ExpansionTile(
//             title: Text(feature.name,
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             subtitle: Text('Level ${feature.level} • ${feature.source}'),
//             children: feature.entries.map((entry) {
//               if (entry is StringEntry) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 4.0),
//                   child: Text(entry.text,
//                       style: Theme.of(context).textTheme.bodyMedium),
//                 );
//               }
//               return const SizedBox.shrink(); // Handle ObjectEntry if needed
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }

// class _BiographyTab extends StatelessWidget {
//   final CharacterSheetState controller;
//   const _BiographyTab({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: [
//         _BioCard(
//             title: "Personality Traits", text: controller.personalityTraits),
//         _BioCard(title: "Ideals", text: controller.ideals),
//         _BioCard(title: "Bonds", text: controller.bonds),
//         _BioCard(title: "Flaws", text: controller.flaws),
//       ],
//     );
//   }
// }

// // --- REUSABLE UI COMPONENTS ---
// class _StatDisplay extends StatelessWidget {
//   final String label;
//   final String value;
//   const _StatDisplay({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 100,
//       child: Column(
//         children: [
//           Text(value, style: Theme.of(context).textTheme.headlineMedium),
//           Text(label, style: Theme.of(context).textTheme.bodySmall),
//         ],
//       ),
//     );
//   }
// }

// class _AbilityScoreCard extends StatelessWidget {
//   final String ability;
//   final int score;
//   final int modifier;
//   const _AbilityScoreCard(
//       {required this.ability, required this.score, required this.modifier});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(ability.substring(0, 3).toUpperCase(),
//               style: Theme.of(context).textTheme.titleMedium),
//           const SizedBox(height: 4),
//           Text(modifier >= 0 ? '+$modifier' : '$modifier',
//               style: Theme.of(context).textTheme.headlineSmall),
//           const SizedBox(height: 4),
//           Chip(
//             label: Text(score.toString()),
//             visualDensity: VisualDensity.compact,
//             padding: EdgeInsets.zero,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SkillRow extends StatelessWidget {
//   final String skillName;
//   final int bonus;
//   const _SkillRow({required this.skillName, required this.bonus});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(bonus >= 0 ? '+$bonus' : '$bonus',
//               style:
//                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           const SizedBox(width: 16),
//           Text(skillName),
//         ],
//       ),
//     );
//   }
// }

// class _BioCard extends StatelessWidget {
//   final String title;
//   final String text;
//   const _BioCard({required this.title, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: Theme.of(context).textTheme.titleLarge),
//             const Divider(height: 16),
//             Text(text, style: Theme.of(context).textTheme.bodyMedium),
//           ],
//         ),
//       ),
//     );
//   }
// }

// --- Constants for Color Coding ---
const Map<String, Color> abilityColors = {
  'Strength': Colors.redAccent,
  'Dexterity': Colors.greenAccent,
  'Constitution': Colors.brown,
  'Intelligence': Colors.blueAccent,
  'Wisdom': Colors.purpleAccent,
  'Charisma': Colors.orangeAccent,
};

const Map<String, String> skillToAbilityMap = {
  'Athletics': 'Strength',
  'Acrobatics': 'Dexterity',
  'Sleight of Hand': 'Dexterity',
  'Stealth': 'Dexterity',
  'Arcana': 'Intelligence',
  'History': 'Intelligence',
  'Investigation': 'Intelligence',
  'Nature': 'Intelligence',
  'Religion': 'Intelligence',
  'Animal Handling': 'Wisdom',
  'Insight': 'Wisdom',
  'Medicine': 'Wisdom',
  'Perception': 'Wisdom',
  'Survival': 'Wisdom',
  'Deception': 'Charisma',
  'Intimidation': 'Charisma',
  'Performance': 'Charisma',
  'Persuasion': 'Charisma',
};

class CharacterSheetScreen extends ConsumerStatefulWidget {
  const CharacterSheetScreen({super.key});

  @override
  ConsumerState<CharacterSheetScreen> createState() =>
      _CharacterSheetScreenState();
}

class _CharacterSheetScreenState extends ConsumerState<CharacterSheetScreen> {
  int _selectedIndex = 0;

  void _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    // In a real app, you would use this line instead:
    final controller = ref.watch(StateService.characterListProvider);
    // For demonstration purposes, we create an instance:

    final character = controller.build(); // Simulates fetching the data

    final List<Widget> pages = [
      _CoreTab(controller: character, viewModel: controller),
      _FeaturesTab(controller: character, viewModel: controller),
      _BiographyTab(controller: character, viewModel: controller),
    ];
    final List<String> pageTitles = [
      "Combat & Skills",
      "Features",
      "Biography"
    ];

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Character Sections',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shield_outlined),
              title: const Text('Combat & Skills'),
              selected: _selectedIndex == 0,
              onTap: () => _onSelectItem(0),
            ),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Features'),
              selected: _selectedIndex == 1,
              onTap: () => _onSelectItem(1),
            ),
            ListTile(
              leading: const Icon(Icons.book_outlined),
              title: const Text('Biography'),
              selected: _selectedIndex == 2,
              onTap: () => _onSelectItem(2),
            ),
          ],
        ),
      ),
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

  Widget? _buildFab(BuildContext context, CharacterSheetViewModel viewModel) {
    if (_selectedIndex == 1) {
      return FloatingActionButton(
        onPressed: () => _showAddFeatureDialog(context, viewModel),
        tooltip: 'Add Feature',
        child: const Icon(Icons.add),
      );
    }
    if (_selectedIndex == 2) {
      return FloatingActionButton(
        onPressed: () => _showAddBioDialog(context, viewModel),
        tooltip: 'Add Biography Entry',
        child: const Icon(Icons.add),
      );
    }
    return null;
  }
}

// --- HEADER WIDGET (Unchanged) ---
class _CharacterHeader extends StatelessWidget {
  final CharacterSheetState controller;
  const _CharacterHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image.asset( ... ) // Your image here
        Container(color: Colors.blueGrey[800]), // Placeholder background
        Positioned(
          bottom: 70,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.classLevelDisplay,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    shadows: [const Shadow(blurRadius: 4)]),
              ),
              Text(
                '${controller.race} • ${controller.background}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- TAB WIDGETS (Updated) ---

class _CoreTab extends StatefulWidget {
  final CharacterSheetState controller;
  final CharacterSheetViewModel viewModel; // To call update methods
  const _CoreTab({required this.controller, required this.viewModel});

  @override
  State<_CoreTab> createState() => _CoreTabState();
}

class _CoreTabState extends State<_CoreTab> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        // Main Stats (HP, AC, etc.)
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runSpacing: 16,
          spacing: 8,
          children: [
            _StatDisplay(
              label: "Armor Class",
              value: widget.controller.armorClass.toString(),
              isEditing: _isEditing,
              onIncrement: () => widget.viewModel
                  .updateArmorClass(widget.controller.armorClass + 1),
              onDecrement: () => widget.viewModel
                  .updateArmorClass(widget.controller.armorClass - 1),
            ),
            _StatDisplay(
              label: "Hit Points",
              value: widget.controller.hitPoints.toString(),
              isEditing: _isEditing,
              onIncrement: () => widget.viewModel
                  .updateHitPoints(widget.controller.hitPoints + 1),
              onDecrement: () => widget.viewModel
                  .updateHitPoints(widget.controller.hitPoints - 1),
            ),
            _StatDisplay(
              label: "Speed",
              value: "${widget.controller.speed} ft.",
              isEditing: _isEditing,
              onIncrement: () =>
                  widget.viewModel.updateSpeed(widget.controller.speed + 5),
              onDecrement: () =>
                  widget.viewModel.updateSpeed(widget.controller.speed - 5),
            ),
          ],
        ),
        const Divider(height: 32),
        // Ability Scores
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: widget.controller.abilityScores.length,
          itemBuilder: (context, index) {
            final ability =
                widget.controller.abilityScores.keys.elementAt(index);
            return _AbilityScoreCard(
              ability: ability,
              score: widget.controller.abilityScores[ability]!,
              modifier: widget.controller.abilityModifiers[ability]!,
              color: abilityColors[ability]!,
            );
          },
        ),
        const Divider(height: 32),
        // Skills
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Skills", style: Theme.of(context).textTheme.titleLarge),
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit),
              tooltip: _isEditing ? 'Save Changes' : 'Edit Stats',
              onPressed: () => setState(() => _isEditing = !_isEditing),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (var entry in widget.controller.skillBonuses.entries)
          _SkillRow(
            skillName: entry.key,
            bonus: entry.value,
            color: abilityColors[skillToAbilityMap[entry.key]] ?? Colors.grey,
          )
      ],
    );
  }
}

class _FeaturesTab extends ConsumerStatefulWidget {
  final CharacterSheetState controller;
  final CharacterSheetViewModel viewModel;
  const _FeaturesTab(
      {required this.controller, required this.viewModel, super.key});

  @override
  ConsumerState<_FeaturesTab> createState() => _FeaturesTabState();
}

class _FeaturesTabState extends ConsumerState<_FeaturesTab> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(StateService.characterListProvider);

    if (viewModel.character.features.isEmpty) {
      return const Center(
        child: Text("No features yet. Add one with the '+' button!"),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: viewModel.character.features.length,
      itemBuilder: (context, index) {
        final feature = viewModel.character.features[index];
        print('on build method : ${viewModel.character.features.length}');
        print(feature.toJson());
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            title: Text(
              feature.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Level ${feature.level} • ${feature.source}'),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  feature.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BiographyTab extends ConsumerStatefulWidget {
  final CharacterSheetState controller;
  final CharacterSheetViewModel viewModel;
  const _BiographyTab(
      {required this.controller, required this.viewModel, super.key});

  @override
  ConsumerState<_BiographyTab> createState() => _BiographyTabState();
}

class _BiographyTabState extends ConsumerState<_BiographyTab> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    if (controller.biographyEntries.isEmpty) {
      return const Center(
        child: Text("No biography entries yet. Add one with the '+' button!"),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: controller.biographyEntries.length,
      itemBuilder: (context, index) {
        final entry = controller.biographyEntries[index];
        return _BioCard(title: entry.title, text: entry.text);
      },
    );
  }
}

// --- REUSABLE UI COMPONENTS (Updated) ---

class _StatDisplay extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditing;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const _StatDisplay({
    required this.label,
    required this.value,
    this.isEditing = false,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // Increased width for edit buttons
      child: Column(
        children: [
          if (isEditing)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: onDecrement,
                    iconSize: 20),
                Text(value, style: Theme.of(context).textTheme.headlineSmall),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: onIncrement,
                    iconSize: 20),
              ],
            )
          else
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _AbilityScoreCard extends StatelessWidget {
  final String ability;
  final int score;
  final int modifier;
  final Color color;
  const _AbilityScoreCard(
      {required this.ability,
      required this.score,
      required this.modifier,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color.withOpacity(0.7), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ability.substring(0, 3).toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(modifier >= 0 ? '+$modifier' : '$modifier',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Chip(
            label: Text(score.toString()),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  final String skillName;
  final int bonus;
  final Color color;
  const _SkillRow(
      {required this.skillName, required this.bonus, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Text(bonus >= 0 ? '+$bonus' : '$bonus',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: color)),
          ),
          const SizedBox(width: 16),
          Text(skillName),
        ],
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  final String title;
  final String text;
  const _BioCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const Divider(height: 16),
            Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

// --- DIALOGS FOR ADDING NEW ITEMS ---

void _showAddFeatureDialog(
    BuildContext context, CharacterSheetViewModel viewModel) {
  final nameController = TextEditingController();
  final levelController = TextEditingController();
  final sourceController = TextEditingController();
  final descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add New Feature'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Feature Name')),
              TextField(
                  controller: levelController,
                  decoration: const InputDecoration(labelText: 'Level'),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: sourceController,
                  decoration: const InputDecoration(
                      labelText: 'Source (e.g., Class, Race)')),
              TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await viewModel.addFeature(ClassFeature(
                  name: nameController.text,
                  source: sourceController.text,
                  level: int.parse(levelController.text),
                  entries: [StringEntry(descriptionController.text)],
                  description: descriptionController.text));
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

void _showAddBioDialog(
    BuildContext context, CharacterSheetViewModel viewModel) {
  final titleController = TextEditingController();
  final textController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Biography Entry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Title (e.g., Character Lore)')),
              TextField(
                  controller: textController,
                  decoration: const InputDecoration(labelText: 'Text'),
                  maxLines: 5),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              // viewModel.addBioEntry(...)
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
