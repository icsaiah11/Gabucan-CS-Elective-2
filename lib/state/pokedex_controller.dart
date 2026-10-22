import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

final pokedexProvider = NotifierProvider<PokedexController, PokedexState>(
  PokedexController.new,
);

class PokedexState {
  const PokedexState({
    this.pokemon = const [],
    this.loading = false,
    this.error,
    this.nicknames = const {},
    this.favorites = const {},
    this.selectedType,
    this.selectedPokemon,
  });

  final List<Pokemon> pokemon;
  final bool loading;
  final String? error;
  final Map<int, String> nicknames;
  final Set<int> favorites;
  final String? selectedType;
  final Pokemon? selectedPokemon;

  List<Pokemon> get visiblePokemon => pokemon
      .where((p) => selectedType == null || p.types.contains(selectedType))
      .toList(growable: false);
  List<Pokemon> get favoritePokemon =>
      pokemon.where((p) => favorites.contains(p.id)).toList(growable: false);
  List<String> get availableTypes =>
      pokemon.expand((p) => p.types).toSet().toList()..sort();
  String? nicknameFor(Pokemon p) => nicknames[p.id];
}

class PokedexController extends Notifier<PokedexState> {
  static const _limit = 30;
  final http.Client _client = http.Client();

  @override
  PokedexState build() {
    ref.onDispose(_client.close);
    return const PokedexState();
  }

  Future<void> fetch() async {
    state = PokedexState(
      pokemon: state.pokemon,
      loading: true,
      nicknames: state.nicknames,
      favorites: state.favorites,
      selectedType: state.selectedType,
      selectedPokemon: state.selectedPokemon,
    );
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$_limit'),
      );
      if (response.statusCode != 200) {
        throw Exception('PokéAPI returned status ${response.statusCode}.');
      }
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      final results = (payload['results'] as List<dynamic>? ?? const []).take(
        _limit,
      );
      final pokemon = await Future.wait(
        results.map((item) async {
          final entry = item as Map<String, dynamic>;
          final detailResponse = await _client.get(
            Uri.parse(entry['url'] as String),
          );
          if (detailResponse.statusCode != 200) {
            throw Exception('Could not load Pokémon details.');
          }
          return Pokemon.fromJson(
            entry,
            details: jsonDecode(detailResponse.body) as Map<String, dynamic>,
          );
        }),
      );
      state = PokedexState(
        pokemon: pokemon,
        nicknames: state.nicknames,
        favorites: state.favorites,
        selectedType: state.selectedType,
        selectedPokemon: state.selectedPokemon,
      );
    } catch (_) {
      state = PokedexState(
        pokemon: state.pokemon,
        error: 'Could not load Pokémon. Check your connection and try again.',
        nicknames: state.nicknames,
        favorites: state.favorites,
        selectedType: state.selectedType,
        selectedPokemon: state.selectedPokemon,
      );
    }
  }

  void selectPokemon(Pokemon? pokemon) =>
      state = _copy(selectedPokemon: pokemon, clearSelected: pokemon == null);
  void setType(String? type) =>
      state = _copy(selectedType: type, clearType: type == null);
  void toggleFavorite(Pokemon pokemon) {
    final favorites = {...state.favorites};
    favorites.contains(pokemon.id)
        ? favorites.remove(pokemon.id)
        : favorites.add(pokemon.id);
    state = _copy(favorites: favorites);
  }

  void saveNickname(Pokemon pokemon, String value) {
    final nicknames = {...state.nicknames};
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      nicknames.remove(pokemon.id);
    } else {
      nicknames[pokemon.id] = trimmed;
    }
    state = _copy(nicknames: nicknames);
  }

  void removeNickname(Pokemon pokemon) => saveNickname(pokemon, '');

  PokedexState _copy({
    Map<int, String>? nicknames,
    Set<int>? favorites,
    String? selectedType,
    bool clearType = false,
    Pokemon? selectedPokemon,
    bool clearSelected = false,
  }) => PokedexState(
    pokemon: state.pokemon,
    loading: state.loading,
    error: state.error,
    nicknames: nicknames ?? state.nicknames,
    favorites: favorites ?? state.favorites,
    selectedType: clearType ? null : selectedType ?? state.selectedType,
    selectedPokemon: clearSelected
        ? null
        : selectedPokemon ?? state.selectedPokemon,
  );
}
