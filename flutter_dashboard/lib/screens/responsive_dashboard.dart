import 'package:flutter/material.dart';

import '../layouts/desktop_layout.dart';
import '../layouts/tablet_layout.dart';
import '../layouts/mobile_layout.dart';
import '../utils/platform_utils.dart';

class ResponsiveDashboard extends StatefulWidget {
  const ResponsiveDashboard({super.key});

  @override
  State<ResponsiveDashboard> createState() => _ResponsiveDashboardState();
}

class _ResponsiveDashboardState extends State<ResponsiveDashboard> {
  int _selectedIndex = 0;

  void _onNavSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine device type based on width
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1200;
        final isDesktop = constraints.maxWidth >= 1200;

        if (isDesktop) {
          return DesktopLayout(
            isCupertino: isPlatformIOS,
            selectedIndex: _selectedIndex,
            onNavSelected: _onNavSelected,
          );
        } else if (isTablet) {
          return TabletLayout(isCupertino: isPlatformIOS);
        } else {
          return MobileLayout(
            isCupertino: isPlatformIOS,
            selectedIndex: _selectedIndex,
            onNavSelected: _onNavSelected,
          );
        }
      },
    );
  }
}
