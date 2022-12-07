import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../Providers/ProductProvider.dart';
import '../Providers/CartProvider.dart';
import '../Providers/OrderProvider.dart';

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
