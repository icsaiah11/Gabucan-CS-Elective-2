import 'package:flutter/material.dart';

class Eyebrow extends StatelessWidget {
  const Eyebrow({required this.text, this.color, super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.primary,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.35,
      ),
    );
  }
}
