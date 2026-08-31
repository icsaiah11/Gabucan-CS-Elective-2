import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/dashboard_content.dart';

/// TABLET LAYOUT: 2-column grid, no sidebar.
class TabletLayout extends StatelessWidget {
  final bool isCupertino;

  const TabletLayout({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DashboardContent(columns: 2, isCupertino: isCupertino),
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
    );
  }
}
