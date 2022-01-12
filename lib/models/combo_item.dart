class ComboItem {
  late final String itemName;
  late final String itemSize;
  ComboItem({required this.itemName, required this.itemSize});

  ComboItem.fromJson(Map<String, dynamic> json) {
    itemName = json['product_name'];
    itemSize = json['product_size'];
  }
}
