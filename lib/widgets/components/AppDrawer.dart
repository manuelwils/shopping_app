import 'package:flutter/material.dart';

import '../../Screens/Auth/AuthScreen.dart';
import '../../Screens/UserProductScreen.dart';
import '../../Screens/OrderScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          builListTile(
            'Shop',
            Icons.shop,
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          builListTile(
            'Orders',
            Icons.shopping_cart,
            () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routeName),
          ),
          builListTile(
            'Manage',
            Icons.manage_accounts,
            () => Navigator.of(context)
                .pushReplacementNamed(UserProductScreen.routeName),
          ),
          builListTile(
            'Logout',
            Icons.logout,
            () => Navigator.of(context)
                .pushReplacementNamed(AuthScreen.routeName),
          ),
        ],
      ),
    );
  }
}

Widget builListTile(String title, IconData icon, VoidCallback callback) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: callback,
  );
}
