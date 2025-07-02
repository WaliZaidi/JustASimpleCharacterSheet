import 'package:flutter/material.dart';

import '../../models/character_model.dart';

class SkillRow extends StatelessWidget {
  final Skill skill;

  const SkillRow({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bonusSign = skill.bonus >= 0 ? '+' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            skill.isProficient
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: skill.isProficient
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade400,
            size: 20,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 120,
            child: Text(skill.name, style: const TextStyle(fontSize: 16)),
          ),
          Text('(${skill.ability})',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
          const Spacer(),
          Text(
            '$bonusSign${skill.bonus}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
