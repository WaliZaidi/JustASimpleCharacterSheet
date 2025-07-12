import 'package:dnd_app_v2/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../models/spell_model.dart';
import 'info_pill.dart';

class SpellListCard extends StatelessWidget {
  final Spell spell;
  final VoidCallback? onTap;

  const SpellListCard({
    Key? key,
    required this.spell,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(spell.name),
      shape: Border.all(
        color: const Color.fromARGB(255, 71, 61, 51),
        width: 1.0,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      minVerticalPadding: 10.0,
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: Row(
          children: <Widget>[
            InfoPill(
              text: spell.level == 0 ? 'Cantrip' : 'Level ${spell.level}',
              color: Utils.instance.getLevelColor(spell.level),
            ),
            const SizedBox(width: 8.0),
            InfoPill(
              text: Utils.instance.getSchoolName(spell.school),
              color: Utils.instance.getSchoolColor(spell.school),
            ),
          ],
        ),
      ),
      trailing:
          Text(spell.source, style: Theme.of(context).textTheme.bodySmall),
      onTap: onTap,
    );
  }
}
