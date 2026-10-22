import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pokemon.dart';
import '../state/pokedex_controller.dart';

class PokemonCard extends ConsumerWidget {
  const PokemonCard({required this.pokemon, required this.onTap, super.key});
  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(pokedexProvider);
    final nickname = data.nicknameFor(pokemon);
    final favorite = data.favorites.contains(pokemon.id);
    final colors = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colors.primary.withValues(alpha: .16)),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 18, 10, 10),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      pokemon.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.broken_image_outlined,
                        size: 52,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    pokemon.formattedId,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    pokemon.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (nickname != null)
                    Text(
                      '“$nickname”',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 2,
            child: IconButton(
              tooltip: favorite ? 'Remove from favorites' : 'Add to favorites',
              onPressed: () =>
                  ref.read(pokedexProvider.notifier).toggleFavorite(pokemon),
              icon: Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: favorite ? Colors.red : colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
