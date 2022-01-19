import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class ItemInCart extends StatelessWidget {
  final CartItem cartItem;
  final List<List<int>> cartItemKey;
  ItemInCart({required this.cartItem, required this.cartItemKey});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () {
        print(
            'product id: ${cartItem.productId} & product Size Id: ${cartItem.productSize.id} & extras ids: ${cartItem.selectedExtras.map((element) => element.id.toString() + "-")} & combo id: ${cartItem.combo?.id ?? "no combo"} & comboItem id: ${cartItem.combo?.comboItems.map((e) => e.id.toString() + "-") ?? "no combo"}');
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      cart.removeItem(cartItemKey);
                    },
                    icon: Icon(Icons.delete_forever, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          cartItem.productName,
                          style: TextStyle(fontSize: 25),
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('product size: ${cartItem.productSize.sizeName}'),
                        Text('${cartItem.productSize.sizePrice} LE'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('combo: ${cartItem.combo?.comboSizeName ?? 'NO'}'),
                        Text('${cartItem.combo?.comboPrice ?? '0'} LE')
                      ],
                    ),
                    if (cartItem.selectedComboOptions != null)
                      ListView(
                          shrinkWrap: true,
                          children:
                              cartItem.selectedComboOptions!.map((option) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(option.itemName),
                              ],
                            );
                          }).toList()),
                    ListView(
                      shrinkWrap: true,
                      children: cartItem.selectedExtras.isNotEmpty
                          ? cartItem.selectedExtras.map((extraItem) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(extraItem.extraName),
                                  Text('${extraItem.extraPrice} LE')
                                ],
                              );
                            }).toList()
                          : [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text('No Extras'), Text('0 LE')],
                              )
                            ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            cart.decreaseItem(cartItemKey, cartItem);
                          },
                          icon: Icon(Icons.remove_circle),
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          onPressed: () {
                            cart.increaseItem(cartItemKey, cartItem);
                          },
                          icon: Icon(Icons.add_circle),
                        ),
                      ],
                    ),
                    Text('Item price: ${cart.itemPrice(cartItem)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
