import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/pokemon_provider.dart';
import 'package:flutter_application_2/screens/pokedex_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

String _responseBody({int count = 30}) {
  final results = List.generate(
    count,
    (index) => {
      'name': 'pokemon${index + 1}',
      'url': 'https://pokeapi.co/api/v2/pokemon/${index + 1}/',
    },
  );
  return '{"results": ${_jsonList(results)}}';
}

String _jsonList(List<Map<String, String>> values) =>
    '[${values.map((item) {
      return '{"name":"${item['name']}","url":"${item['url']}"}';
    }).join(',')}]';

Widget _testApp(PokemonProvider provider) {
  return ChangeNotifierProvider.value(
    value: provider,
    child: const MaterialApp(home: PokedexScreen()),
  );
}

void main() {
  testWidgets('shows loading, then displays 30 Pokémon in a grid', (
    tester,
  ) async {
    final response = Completer<http.Response>();
    final provider = PokemonProvider(
      client: MockClient((_) => response.future),
    );

    await tester.pumpWidget(_testApp(provider));
    final request = provider.fetchPokemon();
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    response.complete(http.Response(_responseBody(), 200));
    await request;
    await tester.pump();
    expect(provider.pokemon, hasLength(30));
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Pokemon1'), findsOneWidget);
  });

  testWidgets('shows an error state and retries through the provider', (
    tester,
  ) async {
    var calls = 0;
    final provider = PokemonProvider(
      client: MockClient((_) async {
        calls++;
        return calls == 1
            ? http.Response('server error', 500)
            : http.Response(_responseBody(), 200);
      }),
    );

    await provider.fetchPokemon();
    await tester.pumpWidget(_testApp(provider));
    expect(
      find.text('Could not load Pokémon. Please try again.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(provider.status, PokemonStatus.success);
    expect(calls, 2);
  });

  testWidgets('opens detail page using the provider selection', (tester) async {
    final provider = PokemonProvider(
      client: MockClient((_) async => http.Response(_responseBody(), 200)),
    );
    await provider.fetchPokemon();
    await tester.pumpWidget(_testApp(provider));

    await tester.tap(find.text('Pokemon1'));
    await tester.pumpAndSettle();

    expect(provider.selectedPokemon?.id, 1);
    expect(find.text('#001'), findsOneWidget);
    expect(find.text('Pokemon1'), findsWidgets);
  });

  testWidgets('refresh button re-triggers the provider API call', (
    tester,
  ) async {
    var calls = 0;
    final provider = PokemonProvider(
      client: MockClient((_) async {
        calls++;
        return http.Response(_responseBody(), 200);
      }),
    );
    await provider.fetchPokemon();
    await tester.pumpWidget(_testApp(provider));

    await tester.tap(find.byTooltip('Refresh Pokémon'));
    await tester.pumpAndSettle();

    expect(calls, 2);
    expect(provider.status, PokemonStatus.success);
  });
}
