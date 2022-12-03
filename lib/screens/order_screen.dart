import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: Column(),
    );
  }
}
