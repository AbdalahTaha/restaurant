import './combo_item.dart';

class Combo {
  late final String comboSizeName;
  late final double comboPrice;
  late final List<ComboItem> comboItems;
  late final int id;

  Combo(
      {required this.comboSizeName,
      required this.comboPrice,
      required this.comboItems,
      required this.id});

  Combo.fromJson(Map<String, dynamic> json) {
    comboSizeName = json['size_name'];
    comboPrice = json['price'].toDouble();
    id = json['combo_size'];

    List<ComboItem> _comboItems = <ComboItem>[];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        _comboItems.add(ComboItem.fromJson(v));
      });
    }
    comboItems = _comboItems;
  }
}
