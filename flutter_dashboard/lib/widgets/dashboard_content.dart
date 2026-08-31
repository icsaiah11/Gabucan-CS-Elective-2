import 'package:flutter/material.dart';

import '../models/dashboard_card_data.dart';
import 'dashboard_card.dart';

/// The scrollable grid of stat cards, with an optional welcome header
/// (Material only — Cupertino already has a nav bar title).
class DashboardContent extends StatelessWidget {
  final int columns;
  final bool isCupertino;

  const DashboardContent({
    super.key,
    required this.columns,
    required this.isCupertino,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCupertino) ...[
          const Text(
            'Welcome Back',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s what\'s happening with your business today.',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
        ],
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: dashboardCards.length,
          itemBuilder: (context, index) {
            final card = dashboardCards[index];
            return DashboardCard(
              title: card.title,
              value: card.value,
              icon: card.icon,
              color: card.color,
              isCupertino: isCupertino,
            );
          },
        ),
      ],
    );
  }
}
