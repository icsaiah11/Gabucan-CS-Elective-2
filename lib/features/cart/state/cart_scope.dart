import 'package:flutter/widgets.dart';

import 'cart_controller.dart';

class CartScope extends InheritedNotifier<CartController> {
  const CartScope(
      {required CartController controller, required super.child, super.key})
      : super(notifier: controller);

  static CartController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartScope>()!.notifier!;
}
