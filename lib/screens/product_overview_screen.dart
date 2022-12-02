import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  AppBar appBar = AppBar(
    title: const Text('Shopping App'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: ProductGrid(),
    );
  }
}
