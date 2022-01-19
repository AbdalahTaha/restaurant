import './product_size.dart';
import './extras.dart';
import './combo.dart';
import './option_product.dart';

class CartItem {
  final String productName;
  final ProductSize productSize;
  final Combo? combo;
  final List<ComboOption>? selectedComboOptions;
  final List<Extra> selectedExtras;
  final double cartItemTotalPrice;
  int quantity;
  final int productId;
  CartItem(
      {required this.productName,
      required this.productSize,
      this.combo,
      required this.selectedExtras,
      required this.quantity,
      required this.productId,
      required this.cartItemTotalPrice,
      this.selectedComboOptions});
}
