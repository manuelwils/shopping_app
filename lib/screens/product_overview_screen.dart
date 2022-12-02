import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/product_provider.dart';

import '../widgets/product_grid.dart';

enum FilterOption {
  favorite,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorite = false;
  @override
  Widget build(BuildContext context) {
    final ProductProvider productsContainer =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption option) {
              setState(() {
                if (option == FilterOption.favorite) {
                  _showFavorite = true;
                } else {
                  _showFavorite = true;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  child: Text('Show Favorites'), value: FilterOption.favorite),
              const PopupMenuItem(
                  child: Text('Show All'), value: FilterOption.all),
            ],
          ),
        ],
      ),
      body: ProductGrid(_showFavorite),
    );
  }
}
