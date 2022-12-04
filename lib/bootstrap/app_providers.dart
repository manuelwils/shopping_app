import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(
    create: (context) => ProductProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => CartProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => OrderProvider(),
  ),
];
