class ComboOption {
  late final String itemName;
  late final String itemSize;
  late final int id;
  ComboOption(
      {required this.itemName, required this.itemSize, required this.id});
  ComboOption.fromJson(Map<String, dynamic> json) {
    itemName = json['product_name'];
    itemSize = json['product_size'];
    id = json['product_id'];
  }
}
