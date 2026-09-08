import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class PaddleShape extends StatelessWidget {
  const PaddleShape({required this.color, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 138,
      width: 90,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 108,
            width: 82,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.elliptical(40, 47)),
              border: Border.all(
                color: Colors.white.withValues(alpha: .55),
                width: 3,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 12,
                  offset: Offset(2, 7),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.bolt_rounded,
                color: Colors.white.withValues(alpha: .85),
                size: 29,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 25,
              height: 43,
              decoration: const BoxDecoration(
                color: Color(0xFF293A36),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(7)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerPaddle extends StatelessWidget {
  const BannerPaddle({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -.28,
      child: const PaddleShape(color: AppTheme.lime),
    );
  }
}
