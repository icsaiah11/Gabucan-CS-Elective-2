import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../catalog/utils/peso_formatter.dart';
import '../../models/cart_item.dart';
import '../../state/cart_scope.dart';

class CheckoutConfirmationScreen extends StatelessWidget {
  const CheckoutConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final List<CartItem> items = cart.items;
    final double total = cart.total;

    return Scaffold(
      appBar: AppBar(title: const Text('ORDER CONFIRMED')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Icon(Icons.check_circle_rounded,
                color: Theme.of(context).colorScheme.primary, size: 68),
            const SizedBox(height: 14),
            Text('Thanks for your order!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('Your court-ready gear is on its way.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 28),
            Text('ORDER SUMMARY',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w900, letterSpacing: 1.1)),
            const SizedBox(height: 10),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: <Widget>[
                      for (final CartItem item in items)
                        _SummaryRow(item: item),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Total',
                                style: TextStyle(fontWeight: FontWeight.w900)),
                            Text(formatPeso(total),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w900))
                          ])
                    ]))),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                cart.clear();
                context.go('/');
              },
              child: const Text('Continue shopping'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.item});
  final CartItem item;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(children: <Widget>[
        Expanded(child: Text('${item.paddle.name} × ${item.quantity}')),
        Text(formatPeso(item.subtotal),
            style: const TextStyle(fontWeight: FontWeight.w800))
      ]));
}
