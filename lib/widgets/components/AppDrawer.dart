import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/Auth.dart';
import '../../Screens/Products/UserProductScreen.dart';
import '../../Screens/Orders/OrderScreen.dart';

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
          builListTile('Logout', Icons.logout, () {
            Navigator.of(context).pop();
            Provider.of<Auth>(context, listen: false).logout();
          }),
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
