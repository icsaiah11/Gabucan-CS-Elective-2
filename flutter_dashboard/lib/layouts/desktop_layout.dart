import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/dashboard_content.dart';
import '../widgets/nav_item.dart';

/// DESKTOP LAYOUT: Sidebar + multi-column grid.
class DesktopLayout extends StatelessWidget {
  final bool isCupertino;
  final int selectedIndex;
  final ValueChanged<int> onNavSelected;

  const DesktopLayout({
    super.key,
    required this.isCupertino,
    required this.selectedIndex,
    required this.onNavSelected,
  });

  Widget _buildSidebar(Color background) {
    return Container(
      width: 250,
      color: background,
      child: ListView(
        children: [
          NavItem(index: 0, label: 'Dashboard', icon: Icons.dashboard, isCupertino: isCupertino, selectedIndex: selectedIndex, onSelected: onNavSelected),
          NavItem(index: 1, label: 'Analytics', icon: Icons.analytics, isCupertino: isCupertino, selectedIndex: selectedIndex, onSelected: onNavSelected),
          NavItem(index: 2, label: 'Reports', icon: Icons.description, isCupertino: isCupertino, selectedIndex: selectedIndex, onSelected: onNavSelected),
          NavItem(index: 3, label: 'Settings', icon: Icons.settings, isCupertino: isCupertino, selectedIndex: selectedIndex, onSelected: onNavSelected),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: DashboardContent(columns: 3, isCupertino: isCupertino),
        ),
      ),
    );

    if (isCupertino) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Dashboard'),
        ),
        child: SafeArea(
          child: Row(
            children: [
              _buildSidebar(CupertinoColors.systemGrey6),
              content,
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: Row(
        children: [
          _buildSidebar(Colors.grey[50]!),
          content,
        ],
      ),
    );
  }
}
