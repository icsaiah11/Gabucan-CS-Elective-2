import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/state_message.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({required this.service, super.key});

  final PokemonService service;

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  late Future<List<Pokemon>> _pokemon;

  @override
  void initState() {
    super.initState();
    _pokemon = widget.service.fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex', style: TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _pokemon,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return StateMessage(
              icon: Icons.cloud_off_outlined,
              title: 'Could not load Pokémon',
              action: _retry,
            );
          }

          final pokemon = snapshot.data ?? <Pokemon>[];
          if (pokemon.isEmpty) {
            return const StateMessage(
              icon: Icons.catching_pokemon,
              title: 'No Pokémon found',
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.82,
            ),
            itemCount: pokemon.length,
            itemBuilder: (context, index) => PokemonCard(pokemon: pokemon[index]),
          );
        },
      ),
    );
  }

  void _retry() {
    setState(() {
      _pokemon = widget.service.fetchPokemon();
    });
  }
}
