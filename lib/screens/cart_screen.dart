import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_test/widgets/cart_item.dart';
import '../providers/cart.dart';
import './invoice.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              CreateInvoice().saveInvoice(cart);
            },
            child: Text('CheckOut'),
          )
        ],
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
            child: ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemInCart(
                        cartItem: cart.cartItems.values.toList()[i],
                        cartItemKey: cart.cartItems.keys.toList()[i]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
