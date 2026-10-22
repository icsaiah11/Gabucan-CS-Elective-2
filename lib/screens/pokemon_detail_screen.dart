import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/pokedex_controller.dart';
import '../widgets/pokedex_panels.dart';

class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokedexProvider);
    final pokemon = state.selectedPokemon;
    if (pokemon == null) {
      return const Scaffold(body: Center(child: Text('No Pokémon selected')));
    }
    final nickname = state.nicknameFor(pokemon);
    final favorite = state.favorites.contains(pokemon.id);
    final controller = ref.read(pokedexProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.displayName),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            onPressed: () => showFavoritesPanel(context),
            icon: Badge(
              label: Text('${state.favorites.length}'),
              child: const Icon(Icons.favorite),
            ),
          ),
          IconButton(
            tooltip: favorite ? 'Remove from favorites' : 'Add to favorites',
            onPressed: () => controller.toggleFavorite(pokemon),
            icon: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: favorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    pokemon.imageUrl,
                    height: 260,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.broken_image_outlined, size: 100),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    pokemon.formattedId,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pokemon.displayName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (nickname != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Nickname: $nickname',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  if (pokemon.types.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Wrap(
                        spacing: 8,
                        children: pokemon.types
                            .map(
                              (type) => Chip(
                                label: Text(
                                  type[0].toUpperCase() + type.substring(1),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 18),
                  OutlinedButton.icon(
                    onPressed: () => showNicknameEditor(context, ref, pokemon),
                    icon: const Icon(Icons.edit),
                    label: Text(
                      nickname == null ? 'Add nickname' : 'Edit nickname',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
