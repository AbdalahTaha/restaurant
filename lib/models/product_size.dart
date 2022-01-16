class ProductSize {
  late final String sizeName;
  late final double sizePrice;
  late final int id;
  var without = [];

  ProductSize(
      {required this.sizeName, required this.sizePrice, required this.id});

  ProductSize.fromJson(Map<String, dynamic> json) {
    sizeName = json['size_name'];
    sizePrice = json['price'].toDouble();
    id = json['size_id'];
  }
  ProductSize.fromJsonPackage(int price) {
    sizeName = "Regular";
    sizePrice = price.toDouble();
  }
}
