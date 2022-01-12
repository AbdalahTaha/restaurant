import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final title;
  CategoryItem(this.title);

  @override
  Widget build(BuildContext context) {
    Color categoryColor = Colors.blue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: ListTile(
        tileColor: categoryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
