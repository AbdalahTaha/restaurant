import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final title;
  final bool isSelected;
  CategoryItem(this.title, {required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 3, horizontal: isSelected ? 5 : 10),
      child: ListTile(
        tileColor: isSelected ? Colors.lightBlueAccent : Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
