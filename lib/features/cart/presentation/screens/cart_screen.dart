import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../catalog/utils/peso_formatter.dart';
import '../../models/cart_item.dart';
import '../../state/cart_scope.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('YOUR CART')),
      body: cart.isEmpty
          ? _EmptyCart()
          : SafeArea(
              top: false,
              child: Column(children: <Widget>[
                Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: cart.items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) =>
                            _CartItemCard(item: cart.items[index]))),
                _CartSummary(
                    total: cart.total,
                    onCheckout: () => context.go('/checkout-confirmation')),
              ])),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const Icon(Icons.shopping_bag_outlined, size: 54),
        const SizedBox(height: 14),
        Text('Your cart is empty',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        OutlinedButton(
            onPressed: () => context.go('/'),
            child: const Text('Browse paddles'))
      ]));
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});
  final CartItem item;
  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: <Widget>[
              Container(
                  width: 54,
                  height: 72,
                  decoration: BoxDecoration(
                      color: item.paddle.background,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.sports_tennis_rounded)),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text(item.paddle.brand.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontWeight: FontWeight.w900)),
                    Text(item.paddle.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 5),
                    Text('${formatPeso(item.paddle.price)} each'),
                    const SizedBox(height: 10),
                    Row(children: <Widget>[
                      IconButton(
                          onPressed: () => cart.decrement(item.paddle.id),
                          icon: const Icon(Icons.remove_circle_outline)),
                      Text('${item.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.w900)),
                      IconButton(
                          onPressed: () => cart.add(item.paddle),
                          icon: const Icon(Icons.add_circle_outline))
                    ])
                  ])),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        tooltip: 'Remove item',
                        onPressed: () => cart.remove(item.paddle.id),
                        icon: const Icon(Icons.close)),
                    Text(formatPeso(item.subtotal),
                        style: const TextStyle(fontWeight: FontWeight.w900))
                  ])
            ])));
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.total, required this.onCheckout});
  final double total;
  final VoidCallback onCheckout;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Color(0x22000000), blurRadius: 14)
          ]),
      child: Column(children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Total',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              Text(formatPeso(total),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w900))
            ]),
        const SizedBox(height: 14),
        SizedBox(
            width: double.infinity,
            child: FilledButton(
                onPressed: onCheckout,
                child: const Text('Proceed to checkout')))
      ]));
}
