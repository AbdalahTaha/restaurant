import './extras.dart';
import './combo.dart';
import './product_size.dart';

class Product {
  late final String productTitle;
  late final String productImage;
  late final List<Extra> extras;
  late final List<Combo> combos;
  late final List<ProductSize> productSizes;
  Product(
      {required this.productTitle,
      required this.productImage,
      required this.extras,
      required this.combos,
      required this.productSizes});

  Product.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
    productTitle = json['product_title'];

    List<Extra> _extras = <Extra>[];
    if (json['extras'] != null) {
      json['extras'].forEach((v) {
        _extras.add(Extra.fromJson(v));
      });
    }
    extras = _extras;

    List<Combo> _combos = <Combo>[];
    if (json['combo_products'] != null) {
      json['combo_products'].forEach((v) {
        _combos.add(Combo.fromJson(v));
      });
    }
    combos = _combos;

    List<ProductSize> _productSizes = <ProductSize>[];
    if (json['sizes'] != null) {
      json['sizes'].forEach((v) {
        _productSizes.add(ProductSize.fromJson(v));
      });
    }
    productSizes = _productSizes;
  }
  Product.fromJsonPackage(Map<String, dynamic> json) {
    productImage = json['image'];
    productTitle = json['package_name'];
    extras = [];
    combos = [];

    List<ProductSize> _productSizes = <ProductSize>[];
    if (json['price'] != null) {
      _productSizes.add(ProductSize.fromJsonPackage(json['price']));
    }
    productSizes = _productSizes;
  }
}
