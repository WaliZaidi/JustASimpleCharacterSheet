import 'package:flutter/material.dart';

class Utils {
  static Utils instance = Utils._();

  Utils._();

  Color getLevelColor(int level) {
    switch (level) {
      case 0:
        return Colors.blueGrey.shade400; // Cantrip: Neutral, utility
      case 1:
        return Colors.teal.shade400; // ---
      case 2:
        return Colors.blue.shade400; //  |-- Low-level, cool "learning" colors
      case 3:
        return Colors.green.shade600; // ---
      case 4:
        return Colors.lime
            .shade700; //  |-- Mid-level, transitioning to warmer, more potent colors
      case 5:
        return Colors.amber.shade700; // ---
      case 6:
        return Colors.orange.shade700; //  |-- High-level, powerful warm colors
      case 7:
        return Colors.red.shade600; // ---
      case 8:
        return Colors.pink.shade500; // Very high-level, distinct "arcane" color
      case 9:
        return Colors.deepPurple.shade500; // Epic-level, ultimate magical power
      default:
        return Colors.grey.shade600; // Fallback for any unexpected values
    }
  }

  Color getSchoolColor(String schoolInitial) {
    switch (schoolInitial.toUpperCase()) {
      case 'A': // Abjuration
        return Colors.teal.shade400;
      case 'C': // Conjuration
        return Colors.orange.shade700;
      case 'D': // Divination
        return Colors.lightBlue.shade500;
      case 'E': // Enchantment
        return Colors.deepPurple.shade300;
      case 'V': // Evocation (V is used in some data sources)
        return Colors.red.shade700;
      case 'I': // Illusion
        return Colors.indigo.shade400;
      case 'N': // Necromancy
        return Colors
            .grey.shade800; // A very dark grey, distinct from the background
      case 'T': // Transmutation
        return Colors.brown.shade400;
      default:
        return Colors.grey.shade700;
    }
  }

// Gets the full school name from its initial.
  String getSchoolName(String schoolInitial) {
    switch (schoolInitial.toUpperCase()) {
      case 'E':
        return 'Enchantment';
      case 'C':
        return 'Conjuration';
      case 'I':
        return 'Illusion';
      case 'T':
        return 'Transmutation';
      case 'A':
        return 'Abjuration';
      case 'D':
        return 'Divination';
      case 'N':
        return 'Necromancy';
      case 'V':
        return 'Evocation';
      default:
        return 'Unknown';
    }
  }
}
