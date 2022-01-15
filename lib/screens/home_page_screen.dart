import 'package:flutter/material.dart';
import 'package:restaurant_test/widgets/cart_badge.dart';
import '../models/product.dart';
import '../services/fetch_home_page_products.dart';
import '../widgets/category_item.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';
import 'product_dialog.dart';
import '../models/categories.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isLoading = true;

  List<Product> productsGrid = [];
  @override
  void initState() {
    FetchProducts.getCategoriesAndPackages().then((_) => {
          setState(() {
            _isLoading = false;
          }),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(child: ch!, value: cart.itemsCount),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CartScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.15),
                  child: ListView.builder(
                    controller: ScrollController(),
                    scrollDirection: Axis.vertical,
                    itemCount: Categories.categories.length,
                    itemBuilder: (context, i) => GestureDetector(
                        child:
                            CategoryItem(Categories.categories[i].categoryName),
                        onTap: () {
                          setState(() {
                            productsGrid = Categories.categories[i].products;
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    controller: ScrollController(),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: productsGrid.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        child: ProductItem(
                          imageUrl: productsGrid[i].productImage,
                          title: productsGrid[i].productTitle,
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              ProductDialog(productsGrid[i]),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width / 200).floor(),
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0),
                  ),
                ),
              ],
            ),
    );
  }
}
