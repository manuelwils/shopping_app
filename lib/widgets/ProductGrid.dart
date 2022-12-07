import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Product.dart';
import '../Providers/ProductProvider.dart';
import './ProductItem.dart';

class ProductGrid extends StatelessWidget {
  bool showFavorite = false;
  ProductGrid(this.showFavorite);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    List<Product> products =
        showFavorite ? productData.favorite : productData.items;
    return GridView.builder(
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 2,
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(5),
    );
  }
}
