import 'package:flutter/material.dart';

import '../../models/paddle.dart';

class PaddleArtwork extends StatelessWidget {
  const PaddleArtwork({required this.paddle, super.key});

  final Paddle paddle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: paddle.background,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.topLeft,
      child: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              paddle.imagePath,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              paddle.badge,
              style: const TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: .5),
            ),
          ),
        ],
      ),
    );
  }
}
