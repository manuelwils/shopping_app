import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ProductProvider.dart';
import '../widgets/components/AppDrawer.dart';
import '../widgets/UserProductItem.dart';
import 'EditProductScreen.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/manage';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemBuilder: (context, index) => UserProductItem(
                productsData.items[index].id!,
                productsData.items[index].title!,
                productsData.items[index].image!,
              ),
          itemCount: productsData.items.length),
    );
  }
}
