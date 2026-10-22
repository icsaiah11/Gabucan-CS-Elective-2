import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pokemon.dart';
import '../state/pokedex_controller.dart';
import '../widgets/pokedex_panels.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/state_message.dart';
import 'pokemon_detail_screen.dart';

class PokedexScreen extends ConsumerStatefulWidget {
  const PokedexScreen({super.key});
  @override
  ConsumerState<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends ConsumerState<PokedexScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(pokedexProvider.notifier).fetch());
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(pokedexProvider);
    final controller = ref.read(pokedexProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            onPressed: () => showFavoritesPanel(context),
            icon: Badge(
              label: Text('${data.favorites.length}'),
              child: const Icon(Icons.favorite),
            ),
          ),
          IconButton(
            tooltip: 'Refresh Pokémon',
            onPressed: data.loading ? null : controller.fetch,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                const Icon(Icons.filter_alt_outlined),
                const SizedBox(width: 8),
                const Text('Type:'),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    initialValue: data.selectedType,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('All types'),
                      ),
                      ...data.availableTypes.map(
                        (t) => DropdownMenuItem<String?>(
                          value: t,
                          child: Text(t[0].toUpperCase() + t.substring(1)),
                        ),
                      ),
                    ],
                    onChanged: data.loading && data.pokemon.isEmpty
                        ? null
                        : controller.setType,
                  ),
                ),
                if (data.selectedType != null)
                  IconButton(
                    tooltip: 'Clear type filter',
                    onPressed: () => controller.setType(null),
                    icon: const Icon(Icons.clear),
                  ),
              ],
            ),
          ),
          Expanded(child: _body(data, controller)),
        ],
      ),
    );
  }

  Widget _body(PokedexState data, PokedexController controller) {
    if (data.loading && data.pokemon.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (data.error != null && data.pokemon.isEmpty) {
      return StateMessage(
        icon: Icons.cloud_off_outlined,
        title: data.error!,
        action: controller.fetch,
      );
    }
    if (data.error != null) {
      return Column(
        children: [
          MaterialBanner(
            content: Text(data.error!),
            actions: [
              TextButton(
                onPressed: controller.fetch,
                child: const Text('Retry'),
              ),
            ],
          ),
          Expanded(child: _grid(data.visiblePokemon)),
        ],
      );
    }
    if (data.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (data.visiblePokemon.isEmpty) {
      return StateMessage(
        icon: Icons.catching_pokemon,
        title: data.pokemon.isEmpty
            ? 'No Pokémon found'
            : 'No Pokémon match this type',
        action: data.pokemon.isEmpty ? controller.fetch : null,
      );
    }
    return _grid(data.visiblePokemon);
  }

  Widget _grid(List<Pokemon> pokemon) => RefreshIndicator(
    onRefresh: ref.read(pokedexProvider.notifier).fetch,
    child: GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: .82,
      ),
      itemCount: pokemon.length,
      itemBuilder: (context, index) {
        final item = pokemon[index];
        return PokemonCard(
          pokemon: item,
          onTap: () {
            ref.read(pokedexProvider.notifier).selectPokemon(item);
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
