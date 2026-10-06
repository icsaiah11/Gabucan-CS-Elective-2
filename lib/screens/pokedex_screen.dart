import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pokemon_provider.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/state_message.dart';
import 'pokemon_detail_screen.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh Pokémon',
            onPressed: provider.status == PokemonStatus.loading
                ? null
                : provider.refreshPokemon,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(context, provider),
    );
  }

  Widget _buildBody(BuildContext context, PokemonProvider provider) {
    switch (provider.status) {
      case PokemonStatus.initial:
      case PokemonStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case PokemonStatus.error:
        return StateMessage(
          icon: Icons.cloud_off_outlined,
          title: provider.errorMessage,
          action: provider.fetchPokemon,
        );
      case PokemonStatus.success:
        if (provider.pokemon.isEmpty) {
          return StateMessage(
            icon: Icons.catching_pokemon,
            title: 'No Pokémon found',
            action: provider.refreshPokemon,
          );
        }

        return RefreshIndicator(
          onRefresh: provider.refreshPokemon,
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.82,
            ),
            itemCount: provider.pokemon.length,
            itemBuilder: (context, index) {
              final pokemon = provider.pokemon[index];
              return PokemonCard(
                pokemon: pokemon,
                onTap: () {
                  context.read<PokemonProvider>().selectPokemon(pokemon);
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PokemonDetailScreen(),
                    ),
                  );
                },
              );
            },
          ),
        );
    }
  }
}
