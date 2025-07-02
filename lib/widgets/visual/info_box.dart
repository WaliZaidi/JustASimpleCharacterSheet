import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const InfoBox({Key? key, required this.label, required this.value, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null) Icon(icon, color: Colors.white70, size: 28),
        if (icon != null) const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
