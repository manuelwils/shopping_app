import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Bootstrap/AppProviders.dart';
import './Routes/PageRoutes.dart';
import './Screens/ProductOverviewScreen.dart';
import './Screens/Auth/AuthScreen.dart';
import './Services/Auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ShoppingApp',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          home: !auth.isAuth ? AuthScreen() : const ProductOverviewScreen(),
          routes: pageRoutes,
        ),
      ),
    );
  }
}
