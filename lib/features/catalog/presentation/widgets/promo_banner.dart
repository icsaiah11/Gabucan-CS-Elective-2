import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'eyebrow.dart';
import 'paddle_shape.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF18372F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Eyebrow(text: 'NEW SEASON', color: AppTheme.lime),
                SizedBox(height: 9),
                Text(
                  'COURT-READY\nGEAR',
                  style: TextStyle(
                    color: AppTheme.lime,
                    fontSize: 25,
                    height: .95,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Find your next favorite paddle.',
                  style: TextStyle(color: Colors.white70, height: 1.3),
                ),
              ],
            ),
          ),
          BannerPaddle(),
        ],
      ),
    );
  }
}
