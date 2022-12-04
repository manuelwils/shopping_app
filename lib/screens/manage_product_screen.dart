import 'package:flutter/material.dart';

import '../dummy_products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/manage_product_item.dart';

class ManageProductScreen extends StatelessWidget {
  static const String routeName = '/manage';
  const ManageProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => ManageProductItem(
          dummyProducts[index].id!,
          dummyProducts[index].title!,
          dummyProducts[index].image!,
        ),
        itemCount: dummyProducts.length,
      ),
    );
  }
}
