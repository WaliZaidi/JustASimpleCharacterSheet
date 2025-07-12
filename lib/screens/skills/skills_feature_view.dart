import 'package:flutter/material.dart';

import '../../models/character_model.dart';
import '../../widgets/visual/skill_row.dart';

class SkillsFeaturesPage extends StatelessWidget {
  final Character character;
  const SkillsFeaturesPage({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    character.skills.sort((a, b) => a.name.compareTo(b.name));

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.visibility, color: Colors.grey.shade700),
                const SizedBox(width: 10),
                const Text("Passive Perception",
                    style: TextStyle(fontSize: 16)),
                const Spacer(),
                Text(
                  character.passivePerception.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text("Skills", style: theme.textTheme.headlineSmall),
        const SizedBox(height: 10),
        Card(
          color: theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: character.skills
                  .map((skill) => SkillRow(skill: skill))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text("Features & Traits", style: theme.textTheme.headlineSmall),
        const SizedBox(height: 10),
        ...character.features.map((feature) => Card(
              color: theme.cardColor,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(feature.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: feature.description.isNotEmpty
                    ? Text(feature.description)
                    : null,
                trailing: feature.hasUses
                    ? const Icon(Icons.check_box_outline_blank,
                        color: Colors.grey)
                    : null,
              ),
            )),
      ],
    );
  }
}
