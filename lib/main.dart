import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FruitListPage(),
      routes: [
        GoRoute(
          path: 'fruit/:name',
          builder: (context, state) =>
              FruitPage(name: state.pathParameters['name']!),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

class FruitListPage extends StatelessWidget {
  const FruitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    const fruits = ['Apple', 'Banana', 'Orange'];

    return Scaffold(
      appBar: AppBar(title: const Text('Fruits')),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return ListTile(
            title: Text(fruit),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.go('/fruit/${fruit.toLowerCase()}'),
          );
        },
      ),
    );
  }
}

class FruitPage extends StatelessWidget {
  const FruitPage({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final emoji = switch (name) {
      'apple' => '🍎',
      'banana' => '🍌',
      'orange' => '🍊',
      _ => '🍓',
    };

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text(emoji, style: const TextStyle(fontSize: 140))),
    );
  }
}
