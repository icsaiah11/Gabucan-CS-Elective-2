import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pokemon.dart';
import '../state/pokedex_controller.dart';

Future<void> showNicknameEditor(
  BuildContext context,
  WidgetRef ref,
  Pokemon pokemon,
) async {
  final current = ref.read(pokedexProvider).nicknameFor(pokemon) ?? '';
  await showDialog<void>(
    context: context,
    builder: (_) => _NicknameDialog(pokemon: pokemon, initial: current),
  );
}

class _NicknameDialog extends ConsumerStatefulWidget {
  const _NicknameDialog({required this.pokemon, required this.initial});
  final Pokemon pokemon;
  final String initial;
  @override
  ConsumerState<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends ConsumerState<_NicknameDialog> {
  late final TextEditingController controller = TextEditingController(
    text: widget.initial,
  );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text('Nickname ${widget.pokemon.displayName}'),
    content: TextField(
      controller: controller,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'Nickname',
        hintText: 'Leave blank to remove',
      ),
    ),
    actions: [
      if (widget.initial.isNotEmpty)
        TextButton(
          onPressed: () {
            ref.read(pokedexProvider.notifier).removeNickname(widget.pokemon);
            Navigator.pop(context);
          },
          child: const Text('Remove'),
        ),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: () {
          ref
              .read(pokedexProvider.notifier)
              .saveNickname(widget.pokemon, controller.text);
          Navigator.pop(context);
        },
        child: const Text('Save'),
      ),
    ],
  );
}

Future<void> showFavoritesPanel(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _FavoritesPanel(),
    );

class _FavoritesPanel extends ConsumerWidget {
  const _FavoritesPanel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokedexProvider);
    final favorites = state.favoritePokemon;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                'Favorite Pokémon',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            if (favorites.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('No Pokémon have been favorited yet.'),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final p = favorites[index];
                    return ListTile(
                      leading: Image.network(
                        p.imageUrl,
                        width: 48,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.catching_pokemon),
                      ),
                      title: Text(state.nicknameFor(p) ?? p.displayName),
                      subtitle: Text(p.displayName),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        tooltip: 'Remove favorite',
                        onPressed: () => ref
                            .read(pokedexProvider.notifier)
                            .toggleFavorite(p),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
