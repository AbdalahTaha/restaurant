import '../models/cart_item.dart';
import 'package:pdf/widgets.dart';

class ItemInCart {
  Widget buildInvoiceItem(CartItem cartItem) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    cartItem.productName,
                    style: TextStyle(fontSize: 15),
                  )),
                ],
              ),
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
                  children: cartItem.selectedComboOptions!.map((option) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(option.itemName),
                  ],
                );
              }).toList()),
            ListView(
              children: cartItem.selectedExtras.isNotEmpty
                  ? cartItem.selectedExtras.map((extraItem) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(extraItem.extraName),
                          Text('${extraItem.extraPrice} LE')
                        ],
                      );
                    }).toList()
                  : [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('No Extras'), Text('0 LE')],
                      )
                    ],
            ),
            SizedBox(height: 5.0),
            Text('Quantity: ${cartItem.quantity}'),
            Text('Sub Total: ${cartItem.cartItemTotalPrice}'),
          ],
        ),
      ),
    );
  }
}
