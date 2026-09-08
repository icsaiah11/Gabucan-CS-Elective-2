import 'package:flutter/foundation.dart';

import '../../catalog/models/paddle.dart';
import '../models/cart_item.dart';

class CartController extends ChangeNotifier {
  final Map<String, CartItem> _items = <String, CartItem>{};

  List<CartItem> get items => List<CartItem>.unmodifiable(_items.values);
  bool get isEmpty => _items.isEmpty;
  int get itemCount =>
      _items.values.fold(0, (total, item) => total + item.quantity);
  double get total => _items.values.fold(0, (sum, item) => sum + item.subtotal);
  int quantityFor(String paddleId) => _items[paddleId]?.quantity ?? 0;

  void add(Paddle paddle) {
    _items.update(
      paddle.id,
      (item) => item.copyWith(quantity: item.quantity + 1),
      ifAbsent: () => CartItem(paddle: paddle, quantity: 1),
    );
    notifyListeners();
  }

  void decrement(String paddleId) {
    final CartItem? item = _items[paddleId];
    if (item == null) return;
    if (item.quantity == 1) {
      _items.remove(paddleId);
    } else {
      _items[paddleId] = item.copyWith(quantity: item.quantity - 1);
    }
    notifyListeners();
  }

  void remove(String paddleId) {
    if (_items.remove(paddleId) != null) notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
