import './product.dart';

class Category {
  late final String categoryName;
  late final List<Product> products;
  Category({required this.categoryName, required this.products});

  Category.fromJson(Map<String, dynamic> json) {
    List<Product> _products = <Product>[];
    categoryName = json['category_name'];
    if (json['products'] != null) {
      json['products'].forEach((v) {
        _products.add(Product.fromJson(v));
      });
    }
    products = _products;
  }
  Category.fromJsonPackage(List<dynamic> json) {
    List<Product> _products = <Product>[];
    categoryName = 'packages';
    json.forEach((v) {
      _products.add(Product.fromJsonPackage(v));
    });
    products = _products;
  }
}
