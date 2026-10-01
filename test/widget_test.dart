import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/models/pokemon.dart';
import 'package:flutter_application_2/screens/pokedex_screen.dart';
import 'package:flutter_application_2/services/pokemon_service.dart';

class FakePokemonService extends PokemonService {
  FakePokemonService(this.result);

  final Future<List<Pokemon>> result;

  @override
  Future<List<Pokemon>> fetchPokemon() => result;
}

void main() {
  testWidgets('shows the loading state before data arrives', (tester) async {
    final request = Completer<List<Pokemon>>();
    await tester.pumpWidget(
      MaterialApp(
        home: PokedexScreen(
          service: FakePokemonService(request.future),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    request.complete(<Pokemon>[]);
    await tester.pump();
  });

  testWidgets('shows Pokémon in a grid', (tester) async {
    final pokemon = List.generate(
      30,
      (index) => Pokemon(
        name: 'pokemon$index',
        id: index + 1,
        imageUrl: 'https://example.com/$index.png',
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: PokedexScreen(service: FakePokemonService(Future.value(pokemon))),
      ),
    );
    await tester.pump();

    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Pokemon0'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Pokemon29'),
      500,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('Pokemon29'), findsOneWidget);
  });

  testWidgets('shows an error state when loading fails', (tester) async {
    final request = Completer<List<Pokemon>>();
    await tester.pumpWidget(
      MaterialApp(
        home: PokedexScreen(
          service: FakePokemonService(request.future),
        ),
      ),
    );
    request.completeError(Exception('offline'));
    await tester.pump();

    expect(find.text('Could not load Pokémon'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });
}
