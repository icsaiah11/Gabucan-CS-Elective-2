import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/dashboard_content.dart';

/// MOBILE LAYOUT: Single column, with a bottom nav bar on Material.
class MobileLayout extends StatelessWidget {
  final bool isCupertino;
  final int selectedIndex;
  final ValueChanged<int> onNavSelected;

  const MobileLayout({
    super.key,
    required this.isCupertino,
    required this.selectedIndex,
    required this.onNavSelected,
  });

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DashboardContent(columns: 1, isCupertino: isCupertino),
      ),
    );

    if (isCupertino) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Dashboard'),
        ),
        child: SafeArea(child: body),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onNavSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
