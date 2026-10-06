import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

enum PokemonStatus { initial, loading, success, error }

class PokemonProvider extends ChangeNotifier {
  PokemonProvider({http.Client? client}) : _client = client ?? http.Client();

  static const int pokemonLimit = 30;
  static final Uri _pokemonUri = Uri.parse(
    'https://pokeapi.co/api/v2/pokemon?limit=$pokemonLimit',
  );

  final http.Client _client;
  List<Pokemon> _pokemon = const [];
  PokemonStatus _status = PokemonStatus.initial;
  String _errorMessage = '';
  Pokemon? _selectedPokemon;

  List<Pokemon> get pokemon => List.unmodifiable(_pokemon);
  PokemonStatus get status => _status;
  String get errorMessage => _errorMessage;
  Pokemon? get selectedPokemon => _selectedPokemon;

  Future<void> fetchPokemon() async {
    _status = PokemonStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _client.get(_pokemonUri);
      if (response.statusCode != 200) {
        throw Exception('PokéAPI returned status ${response.statusCode}.');
      }

      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      final results = payload['results'] as List<dynamic>? ?? const [];
      _pokemon = results
          .take(pokemonLimit)
          .map((item) => Pokemon.fromJson(item as Map<String, dynamic>))
          .toList(growable: false);
      _status = PokemonStatus.success;
    } catch (_) {
      _status = PokemonStatus.error;
      _errorMessage = 'Could not load Pokémon. Please try again.';
    }

    notifyListeners();
  }

  Future<void> refreshPokemon() => fetchPokemon();

  void selectPokemon(Pokemon pokemon) {
    _selectedPokemon = pokemon;
    notifyListeners();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}
