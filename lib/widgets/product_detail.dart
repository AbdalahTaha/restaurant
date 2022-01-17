import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String detail;
  ProductDetail(this.detail);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          child: Text(
            detail,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

//const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
