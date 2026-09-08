import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class CategoryStrip extends StatelessWidget {
  const CategoryStrip({super.key});

  static const List<String> _labels = <String>[
    'All paddles',
    'Control',
    'Power',
    'Spin',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _labels.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final bool isSelected = index == 0;
          return Chip(
            label: Text(_labels[index]),
            backgroundColor:
                isSelected ? AppTheme.lime : Theme.of(context).cardColor,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w800,
              color: isSelected ? AppTheme.ink : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
          );
        },
      ),
    );
  }
}
