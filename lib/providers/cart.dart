import 'package:collection/collection.dart';
import '../models/cart_item.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  Map<List<List<int>>, CartItem> _cartItems = {};
  Function deepEq = const DeepCollectionEquality().equals;
  Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
  void addItem(List<List<int>> itemId, CartItem item) {
    for (List<List<int>> key in _cartItems.keys) {
      if (deepEq(key[0], itemId[0])) {
        if (unOrdDeepEq(key[1], itemId[1])) {
          _cartItems.update(
            key,
            (existingItem) => CartItem(
              productName: existingItem.productName,
              productSize: existingItem.productSize,
              selectedExtras: existingItem.selectedExtras,
              combo: existingItem.combo,
              quantity: existingItem.quantity + item.quantity,
              productId: existingItem.productId,
              cartItemTotalPrice: existingItem.cartItemTotalPrice,
              selectedComboOptions: existingItem.selectedComboOptions,
            ),
          );
          notifyListeners();
          return;
        }
      }
    }
    _cartItems.addAll({itemId: item});
    notifyListeners();
  }

  Map<List<List<int>>, CartItem> get cartItems {
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

  void removeItem(List<List<int>> itemId) {
    _cartItems.remove(itemId);
    notifyListeners();
  }

  void increaseItem(List<List<int>> itemId, CartItem item) {
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
        selectedComboOptions: existingItem.selectedComboOptions,
      ),
    );
    notifyListeners();
  }

  void decreaseItem(List<List<int>> itemId, CartItem item) {
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
