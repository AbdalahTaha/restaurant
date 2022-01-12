import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  ProductItem({
    required this.title,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (BuildContext context, Object exception, _) {
            return Image.asset(
              'assets/not_available.jpg',
              fit: BoxFit.contain,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
