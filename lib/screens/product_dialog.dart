import 'package:flutter/material.dart';
import 'package:restaurant_test/models/combo.dart';
import '../models/extras.dart';
import '../models/product.dart';
import '../widgets/product_detail.dart';
import '../models/product_size.dart';
import '../models/cart_item.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class ProductDialog extends StatefulWidget {
  final Product selectedProduct;
  ProductDialog(this.selectedProduct);

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  List<bool> _productSizes = [];
  List<bool> _productCombos = [];
  List<bool> _productExtras = [];
  int selectedSizeIndex = 0;
  int selectedComboIndex = -1;
  List<Extra> selectedExtra = [];

  int quantity = 1;

  @override
  void initState() {
    widget.selectedProduct.productSizes.forEach((element) {
      if (widget.selectedProduct.productSizes.first == element)
        _productSizes.add(true);
      else
        _productSizes.add(false);
    });
    _productCombos = List.filled(widget.selectedProduct.combos.length, false);
    _productExtras = List.filled(widget.selectedProduct.extras.length, false);
    super.initState();
  }

  double calculateCartItemPrice(
      ProductSize productSize, Combo? combo, List<Extra> extras) {
    double productPrice = productSize.sizePrice;
    double comboPrice = combo?.comboPrice ?? 0.0;
    double extrasPrice = 0.0;
    for (Extra extra in extras) extrasPrice += extra.extraPrice;
    return productPrice + comboPrice + extrasPrice;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.selectedProduct.productTitle,
              style: TextStyle(color: Colors.black, fontSize: 22.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtons(
                  renderBorder: false,
                  fillColor: Colors.grey[400],
                  children: widget.selectedProduct.productSizes
                      .map((ProductSize element) {
                    return ProductDetail(element.sizeName);
                  }).toList(),
                  isSelected: _productSizes,
                  onPressed: (int newIndex) {
                    if (newIndex != selectedSizeIndex) {
                      setState(() {
                        _productSizes[selectedSizeIndex] = false;
                        _productSizes[newIndex] = true;
                      });
                      selectedSizeIndex = newIndex;
                    }
                  }),
            ),
            Container(
              height: 2.0,
              color: Colors.grey[600],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtons(
                renderBorder: false,
                fillColor: Colors.grey[400],
                children: widget.selectedProduct.combos.map((Combo element) {
                  return ProductDetail(element.comboSizeName);
                }).toList(),
                isSelected: _productCombos,
                onPressed: (int newIndex) {
                  if (selectedComboIndex == -1) {
                    setState(() {
                      _productCombos[newIndex] = true;
                    });
                    selectedComboIndex = newIndex;
                  } else if (newIndex != selectedComboIndex) {
                    setState(() {
                      _productCombos[selectedComboIndex] = false;
                      _productCombos[newIndex] = true;
                    });
                    selectedComboIndex = newIndex;
                  } else {
                    setState(() {
                      _productCombos[selectedComboIndex] = false;
                    });
                    selectedComboIndex = -1;
                  }
                },
              ),
            ),
            Container(
              height: 2.0,
              color: Colors.grey[600],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtons(
                direction: Axis.vertical,
                constraints: BoxConstraints(),
                renderBorder: false,
                fillColor: Colors.grey[400],
                children: widget.selectedProduct.extras.map((Extra element) {
                  return ProductDetail(element.extraName);
                }).toList(),
                isSelected: _productExtras,
                onPressed: (int newIndex) {
                  setState(() {
                    _productExtras[newIndex] = !_productExtras[newIndex];
                  });
                  if (_productExtras[newIndex])
                    selectedExtra.add(widget.selectedProduct.extras[newIndex]);
                  else
                    selectedExtra
                        .remove(widget.selectedProduct.extras[newIndex]);
                },
              ),
            ),
            Container(
              height: 2.0,
              color: Colors.grey[600],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity != 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: Icon(Icons.remove_circle),
                ),
                Text('$quantity'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: Icon(Icons.add_circle),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // print(widget.selectedProduct.productTitle);
                  // print(widget.selectedProduct.productSizes[selectedSizeIndex]
                  //     .sizeName);
                  // if (selectedComboIndex != -1)
                  //   print(widget.selectedProduct.combos[selectedComboIndex]
                  //       .comboSizeName);
                  // else
                  //   print('no combo');
                  // print([...selectedExtra]);
                  cart.addItem(
                    DateTime.now().toString(),
                    CartItem(
                        productName: widget.selectedProduct.productTitle,
                        productSize: widget
                            .selectedProduct.productSizes[selectedSizeIndex],
                        combo: selectedComboIndex == -1
                            ? null
                            : widget.selectedProduct.combos[selectedComboIndex],
                        selectedExtras: [...selectedExtra],
                        quantity: quantity,
                        productId: widget.selectedProduct.id,
                        cartItemTotalPrice: calculateCartItemPrice(
                            widget.selectedProduct
                                .productSizes[selectedSizeIndex],
                            selectedComboIndex == -1
                                ? null
                                : widget
                                    .selectedProduct.combos[selectedComboIndex],
                            [...selectedExtra])),
                  );
                  Navigator.pop(context);
                },
                child: Text('Add To Cart'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orangeAccent)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
