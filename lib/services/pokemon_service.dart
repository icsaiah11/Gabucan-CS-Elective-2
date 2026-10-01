import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonService {
  PokemonService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<Pokemon>> fetchPokemon() async {
    final response = await _client.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=30'),
    );

    if (response.statusCode != 200) {
      throw Exception('PokéAPI returned status ${response.statusCode}.');
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final results = payload['results'] as List<dynamic>? ?? <dynamic>[];
    return results
        .take(30)
        .map((item) => Pokemon.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
