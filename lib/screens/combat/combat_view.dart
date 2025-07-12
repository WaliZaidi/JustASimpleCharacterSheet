import 'package:flutter/material.dart';

import '../../models/character_model.dart';
import '../../widgets/visual/ability_score_card.dart';
import '../../widgets/visual/info_box.dart';

class CombatPage extends StatelessWidget {
  final Character character;
  const CombatPage({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoBox(
                  label: "AC",
                  value: character.armorClass.toString(),
                  icon: Icons.shield_outlined),
              InfoBox(
                  label: "Initiative",
                  value: "+${character.initiative}",
                  icon: Icons.flash_on),
              InfoBox(
                  label: "Speed",
                  value: "${character.speed} ft",
                  icon: Icons.directions_run),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            color: theme.cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Current HP",
                              style: TextStyle(color: Colors.grey.shade600)),
                          Text(
                            character.currentHp.toString(),
                            style: theme.textTheme.displayMedium,
                          ),
                        ],
                      ),
                      Text("/", style: theme.textTheme.displaySmall),
                      Column(
                        children: [
                          Text("Max HP",
                              style: TextStyle(color: Colors.grey.shade600)),
                          Text(
                            character.maxHp.toString(),
                            style: theme.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: character.currentHp / character.maxHp,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.red.shade700),
                  ),
                  const SizedBox(height: 10),
                  Text("Hit Dice: ${character.hitDice}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: character.abilityScores.length,
            itemBuilder: (context, index) {
              return AbilityScoreCard(score: character.abilityScores[index]);
            },
          ),
          const SizedBox(height: 20),
          Text("Weapons & Attacks", style: theme.textTheme.headlineSmall),
          const SizedBox(height: 10),
          ...character.weapons.map((weapon) => Card(
                color: theme.cardColor,
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(weapon.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  subtitle: Text(weapon.notes,
                      style: const TextStyle(color: Colors.black)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Atk: ${weapon.attackBonus}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(
                        "Dmg: ${weapon.damage}",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
