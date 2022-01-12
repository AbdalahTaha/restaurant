import './category.dart';

class Categories {
  static late final List<Category> categories;

  Categories.fromJson(Map<String, dynamic> json) {
    List<Category> _categories = <Category>[];
    if (json['categories'] != null) {
      json['categories'].forEach((v) {
        _categories.add(Category.fromJson(v));
      });
    }
    if (json['packages'] != null) {
      _categories.add(Category.fromJsonPackage(json['packages']));
    }
    categories = _categories;
  }
}
