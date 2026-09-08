import 'package:flutter/material.dart';

import '../../../../core/theme/theme_controller.dart';
import '../../data/paddle_catalog.dart';
import '../widgets/brand_mark.dart';
import '../widgets/category_strip.dart';
import '../widgets/eyebrow.dart';
import '../widgets/paddle_card.dart';
import '../widgets/promo_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const double _tabletBreakpoint = 700;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemeController themeController = ThemeController.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BrandMark(),
            const SizedBox(width: 10),
            Text(
              'PADDLE PROVISIONS',
              style: TextStyle(
                color: themeController.isDark ? Colors.white : null,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip:
                themeController.isDark ? 'Use light theme' : 'Use dark theme',
            icon: Icon(
              themeController.isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: themeController.toggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 32),
          children: <Widget>[
            const Eyebrow(text: 'THE PICKLEBALL EDIT'),
            const SizedBox(height: 8),
            Text(
              'FIND YOUR\nSWEET SPOT.',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w900,
                height: .92,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Premium pickleball paddles for every kind of player — selected for the Philippine court.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 24),
            const PromoBanner(),
            const SizedBox(height: 22),
            const CategoryStrip(),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Featured paddles',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${paddles.length} SELECTED',
                  style: theme.textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columnCount =
                    constraints.maxWidth >= _tabletBreakpoint ? 3 : 2;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paddles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnCount,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: columnCount == 2 ? .62 : .72,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return PaddleCard(paddle: paddles[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
