import 'package:flutter/material.dart';
import '../../models/character_model.dart';

class AbilityScoreCard extends StatelessWidget {
  final AbilityScore score;

  const AbilityScoreCard({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modifierSign = score.modifier >= 0 ? '+' : '';
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(score.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '$modifierSign${score.modifier}',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                score.value.toString(),
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
