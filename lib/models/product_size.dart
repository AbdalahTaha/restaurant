class ProductSize {
  late final String sizeName;
  late final double sizePrice;
  var without = [];

  ProductSize({required this.sizeName, required this.sizePrice});

  ProductSize.fromJson(Map<String, dynamic> json) {
    sizeName = json['size_name'];
    sizePrice = json['price'].toDouble();
  }
  ProductSize.fromJsonPackage(int price) {
    sizeName = "Regular";
    sizePrice = price.toDouble();
  }
}
