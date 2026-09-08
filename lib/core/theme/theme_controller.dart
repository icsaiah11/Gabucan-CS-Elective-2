import 'package:flutter/material.dart';

class ThemeController extends InheritedWidget {
  const ThemeController({
    required this.isDark,
    required this.toggleTheme,
    required super.child,
    super.key,
  });

  final bool isDark;
  final VoidCallback toggleTheme;

  static ThemeController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeController>()!;
  }

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      isDark != oldWidget.isDark;
}
