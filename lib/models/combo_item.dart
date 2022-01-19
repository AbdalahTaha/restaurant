import './option_product.dart';

class ComboItem {
  late final String itemName;
  late final String itemSize;
  late final int id;
  late final bool hasOptions;
  late final List<ComboOption> productOptions;
  ComboItem(
      {required this.itemName,
      required this.itemSize,
      required this.id,
      required this.hasOptions,
      required this.productOptions});

  ComboItem.fromJson(Map<String, dynamic> json) {
    itemName = json['product_name'];
    itemSize = json['product_size'];
    id = json['product_id'];
    hasOptions = json['options'];

    List<ComboOption> _productOptions = <ComboOption>[];
    if (hasOptions) {
      //add default item to the list
      _productOptions
          .add(ComboOption(itemName: itemName, itemSize: itemSize, id: id));

      //adding rest of options to the list
      json['option_product'].forEach((v) {
        _productOptions.add(ComboOption.fromJson(v));
      });
    }
    productOptions = _productOptions;
  }
}
