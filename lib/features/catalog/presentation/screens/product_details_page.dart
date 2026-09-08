import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/state/cart_scope.dart';
import '../../data/paddle_catalog.dart';
import '../../models/paddle.dart';
import '../../utils/peso_formatter.dart';
import '../widgets/paddle_artwork.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.paddleId, super.key});
  final String paddleId;

  @override
  Widget build(BuildContext context) {
    final Paddle paddle = paddles.firstWhere((item) => item.id == paddleId);
    final cart = CartScope.of(context);
    final theme = Theme.of(context);
    final int quantity = cart.quantityFor(paddle.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PADDLE DETAILS'),
        actions: <Widget>[
          IconButton(
            tooltip: 'View cart',
            onPressed: () => context.go('/cart'),
            icon: Badge(
              isLabelVisible: cart.itemCount > 0,
              label: Text('${cart.itemCount}'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(height: 330, child: PaddleArtwork(paddle: paddle)),
            const SizedBox(height: 24),
            Text(paddle.brand.toUpperCase(),
                style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2)),
            const SizedBox(height: 6),
            Text(paddle.name,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            Text(formatPeso(paddle.price),
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 18),
            Text(paddle.description,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
            const SizedBox(height: 26),
            FilledButton.icon(
              onPressed: () {
                cart.add(paddle);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${paddle.name} added to cart')));
              },
              icon: const Icon(Icons.add_shopping_cart_outlined),
              label: Text(quantity == 0
                  ? 'Add to cart'
                  : 'Add another · $quantity in cart'),
            ),
          ],
        ),
      ),
    );
  }
}
