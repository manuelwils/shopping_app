import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/ProductProvider.dart';
import '../../Widgets/components/AppDrawer.dart';
import '../../Providers/CartProvider.dart';
import '../../Widgets/components/Badge.dart';
import '../../Widgets/Products/ProductGrid.dart';
import '../Components/SplashScreen.dart';
import '../Cart/CartScreen.dart';

enum FilterOption {
  favorite,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    final fetchProducts =
        Provider.of<ProductProvider>(context, listen: false).loadAllProducts();
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
                  _showFavorite = false;
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
          Consumer<CartProvider>(
            builder: (ctx, cartItem, ch) => Badge(
              child: ch,
              value: cartItem.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: fetchProducts,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? SplashScreen()
                : RefreshIndicator(
                    onRefresh: () => fetchProducts,
                    child: ProductGrid(_showFavorite),
                  ),
      ),
    );
  }
}
