import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../Services/Auth.dart';
import '../Providers/ProductProvider.dart';
import '../Providers/CartProvider.dart';
import '../Providers/OrderProvider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(
    create: (context) => Auth(),
  ),
  ChangeNotifierProxyProvider<Auth, ProductProvider>(
    create: (context) => ProductProvider(),
    update: (ctx, auth, product) => ProductProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => CartProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => OrderProvider(),
  ),
];
