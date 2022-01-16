import 'package:restaurant_test/models/extras.dart';

import '../models/cart_item.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  void addItem(String itemId, CartItem item) {
    _cartItems.addAll({itemId: item});
    notifyListeners();
  }

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get itemsCount {
    int count = 0;
    _cartItems.values.forEach((cartItem) {
      count = count + cartItem.quantity;
    });
    return count;
  }

  double itemPrice(CartItem item) {
    return item.cartItemTotalPrice * item.quantity;
  }

  double get cartTotalPrice {
    double totalPrice = 0.0;
    for (CartItem item in _cartItems.values)
      totalPrice = totalPrice + itemPrice(item);
    return totalPrice;
  }

  void removeItem(String itemId) {
    _cartItems.remove(itemId);
    notifyListeners();
  }

  void increaseItem(String itemId, CartItem item) {
    _cartItems.update(
      itemId,
      (existingItem) => CartItem(
        productName: existingItem.productName,
        productSize: existingItem.productSize,
        selectedExtras: existingItem.selectedExtras,
        combo: existingItem.combo,
        quantity: existingItem.quantity + 1,
        productId: existingItem.productId,
        cartItemTotalPrice: existingItem.cartItemTotalPrice,
      ),
    );
    notifyListeners();
  }

  void decreaseItem(String itemId, CartItem item) {
    if (item.quantity > 1) {
      _cartItems.update(
        itemId,
        (existingItem) => CartItem(
          productName: existingItem.productName,
          productSize: existingItem.productSize,
          selectedExtras: existingItem.selectedExtras,
          combo: existingItem.combo,
          quantity: existingItem.quantity - 1,
          productId: existingItem.productId,
          cartItemTotalPrice: existingItem.cartItemTotalPrice,
        ),
      );
      notifyListeners();
    }
  }
}
