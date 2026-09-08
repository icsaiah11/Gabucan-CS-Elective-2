import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: AppTheme.lime,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.sports_tennis_rounded,
        size: 18,
        color: AppTheme.ink,
      ),
    );
  }
}
