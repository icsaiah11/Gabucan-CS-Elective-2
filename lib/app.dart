import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/cart/state/cart_controller.dart';
import 'features/cart/state/cart_scope.dart';

class PaddleProvisionsApp extends StatefulWidget {
  const PaddleProvisionsApp({super.key});

  @override
  State<PaddleProvisionsApp> createState() => _PaddleProvisionsAppState();
}

class _PaddleProvisionsAppState extends State<PaddleProvisionsApp> {
  ThemeMode _themeMode = ThemeMode.light;
  late final CartController _cartController;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _cartController = CartController();
    _router = AppRouter.create(_cartController);
  }

  @override
  void dispose() {
    _cartController.dispose();
    _router.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      controller: _cartController,
      child: ThemeController(
        isDark: _themeMode == ThemeMode.dark,
        toggleTheme: _toggleTheme,
        child: MaterialApp.router(
          title: 'Paddle Provisions',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _themeMode,
          routerConfig: _router,
        ),
      ),
    );
  }
}
