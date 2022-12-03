import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        ),
        child: GridTile(
          child: Image.network(product.image!, fit: BoxFit.cover),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => product.toggleFavoriteStatus(),
              ),
            ),
            title: Text(
              product.title!,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            trailing: Consumer<CartProvider>(
              builder: (ctx, cartItem, ch) => IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  cartItem.addToCart(
                    product.id!,
                    product.title!,
                    product.amount!,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
