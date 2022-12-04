import 'package:flutter/material.dart';

import '../screens/manage_product_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/order_screen.dart';

Map<String, Widget Function(BuildContext)> pageRoutes = {
  ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  ManageProductScreen.routeName: (context) => const ManageProductScreen(),
};
