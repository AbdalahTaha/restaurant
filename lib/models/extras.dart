class Extra {
  late final String extraName;
  late final String extraSize;
  late final double extraPrice;
  Extra(
      {required this.extraName,
      required this.extraSize,
      required this.extraPrice});

  Extra.fromJson(Map<String, dynamic> json) {
    extraName = json['product_name'];
    extraSize = json['size_name'];
    extraPrice = json['size_price'].toDouble();
  }
}
