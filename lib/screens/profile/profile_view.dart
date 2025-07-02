// lib/screens/profile_page.dart
import 'package:flutter/material.dart';

import '../../models/character_model.dart';

class ProfilePage extends StatelessWidget {
  final Character character;
  const ProfilePage({Key? key, required this.character}) : super(key: key);

  Widget _buildInfoTile(BuildContext context, String label, String value) {
    return ListTile(
      title: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodySmall?.color)),
      subtitle: Text(value, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: theme.cardColor,
          child: Column(
            children: [
              _buildInfoTile(context, "Background", character.background),
              const Divider(height: 1),
              _buildInfoTile(context, "Alignment", character.alignment),
              const Divider(height: 1),
              _buildInfoTile(context, "Race", character.race),
              const Divider(height: 1),
              _buildInfoTile(context, "Player", character.playerName),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Card(
            color: theme.cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vision",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodySmall?.color)),
                  const SizedBox(height: 4),
                  Text(character.vision, style: theme.textTheme.bodyLarge)
                ],
              ),
            )),
        const SizedBox(height: 20),
        // Placeholder for Inventory
        Card(
            color: theme.cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Inventory", style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  Text("Your inventory would be listed here...",
                      style: TextStyle(color: Colors.grey.shade600))
                ],
              ),
            )),
      ],
    );
  }
}
