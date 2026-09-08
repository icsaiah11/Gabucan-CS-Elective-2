import '../../catalog/models/paddle.dart';

class CartItem {
  const CartItem({required this.paddle, required this.quantity});

  final Paddle paddle;
  final int quantity;

  double get subtotal => paddle.price * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(paddle: paddle, quantity: quantity ?? this.quantity);
}
