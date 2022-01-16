class Extra {
  late final String extraName;
  late final String extraSize;
  late final double extraPrice;
  late final int id;
  Extra(
      {required this.extraName,
      required this.extraSize,
      required this.extraPrice,
      required this.id});

  Extra.fromJson(Map<String, dynamic> json) {
    extraName = json['product_name'];
    extraSize = json['size_name'];
    extraPrice = json['size_price'].toDouble();
    id = json['id'];
  }
}
