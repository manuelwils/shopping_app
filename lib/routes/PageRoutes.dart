import 'package:flutter/material.dart';

import '../Screens/EditProductScreen.dart';
import '../Screens/UserProductScreen.dart';
import '../Screens/CartScreen.dart';
import '../Screens/ProductDetailScreen.dart';
import '../Screens/OrderScreen.dart';
import '../Screens/Auth/AuthScreen.dart';

Map<String, Widget Function(BuildContext)> pageRoutes = {
  AuthScreen.routeName: (context) => AuthScreen(),
  ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  UserProductScreen.routeName: (context) => const UserProductScreen(),
  EditProductScreen.routeName: (context) => const EditProductScreen(),
};
