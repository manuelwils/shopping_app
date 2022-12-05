import 'package:flutter/material.dart';

import '../screens/EditProductScreen.dart';
import '../screens/UserProductScreen.dart';
import '../screens/CartScreen.dart';
import '../screens/ProductDetailScreen.dart';
import '../screens/OrderScreen.dart';

Map<String, Widget Function(BuildContext)> pageRoutes = {
  ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  UserProductScreen.routeName: (context) => const UserProductScreen(),
  EditProductScreen.routeName: (context) => const EditProductScreen(),
};
