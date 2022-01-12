import './combo_item.dart';

class Combo {
  late final String comboSizeName;
  late final double comboPrice;
  late final List<ComboItem> comboItems;

  Combo(
      {required this.comboSizeName,
      required this.comboPrice,
      required this.comboItems});

  Combo.fromJson(Map<String, dynamic> json) {
    comboSizeName = json['size_name'];
    comboPrice = json['price'].toDouble();

    List<ComboItem> _comboItems = <ComboItem>[];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        _comboItems.add(ComboItem.fromJson(v));
      });
    }
    comboItems = _comboItems;
  }
}
