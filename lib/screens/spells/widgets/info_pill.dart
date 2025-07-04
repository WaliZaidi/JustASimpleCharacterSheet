import 'package:flutter/material.dart';

class InfoPill extends StatelessWidget {
  const InfoPill({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        // The background of the pill is now transparent.
        color: Colors.transparent,
        // The border uses the color passed into the widget.
        border: Border.all(
          color: color,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
