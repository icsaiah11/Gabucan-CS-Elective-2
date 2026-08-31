import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../screens/responsive_dashboard.dart';
import '../utils/platform_utils.dart';

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (isPlatformIOS) {
      return CupertinoApp(
        title: 'Dashboard',
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
        ),
        home: const ResponsiveDashboard(),
      );
    } else {
      return MaterialApp(
        title: 'Dashboard',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const ResponsiveDashboard(),
      );
    }
  }
}
