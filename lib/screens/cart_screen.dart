import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_test/widgets/cart_item.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.lightBlue,
            child: Text(
              'Cart Total: ${cart.cartTotalPrice} LE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Expanded(
            child: ListView(
                children: cart.cartItems.entries.map((cartItem) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ItemInCart(
                    cartItem: cartItem.value, cartItemKey: cartItem.key),
              );
            }).toList()),
          ),
        ],
      ),
    );
  }
}
