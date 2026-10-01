import 'package:flutter/material.dart';

import 'screens/pokedex_screen.dart';
import 'services/pokemon_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFEAF3FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF1565C0),
        ),
      ),
      home: PokedexScreen(service: PokemonService()),
    );
  }
}
