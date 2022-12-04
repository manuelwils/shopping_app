import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './bootstrap/app_providers.dart';
import './routes/page_routes.dart';
import './screens/product_overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShoppingApp',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: const ProductOverviewScreen(),
        routes: pageRoutes,
      ),
    );
  }
}
