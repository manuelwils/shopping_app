import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/ProductProvider.dart';
import '../providers/CartProvider.dart';
import '../providers/OrderProvider.dart';

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
