import 'package:flutter/material.dart';

import '../Screens/Products/EditProductScreen.dart';
import '../Screens/Products/UserProductScreen.dart';
import '../Screens/Cart/CartScreen.dart';
import '../Screens/Products/ProductDetailScreen.dart';
import '../Screens/Orders/OrderScreen.dart';
import '../Screens/Auth/AuthScreen.dart';

Map<String, Widget Function(BuildContext)> pageRoutes = {
  AuthScreen.routeName: (context) => AuthScreen(),
  ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  UserProductScreen.routeName: (context) => const UserProductScreen(),
  EditProductScreen.routeName: (context) => const EditProductScreen(),
};
