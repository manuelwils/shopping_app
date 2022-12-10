import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/components/AppDrawer.dart';
import '../Providers/OrderProvider.dart';
import '../Widgets/OrderItem.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isPageLoading = false;

  void changePageLoadingStatus() {
    setState(() {
      _isPageLoading = !_isPageLoading;
    });
  }

  Future<void> loadOrders() async {
    changePageLoadingStatus();
    await Provider.of<OrderProvider>(context, listen: false)
        .loadAllOrders()
        .catchError((exception) => changePageLoadingStatus())
        .then((_) => changePageLoadingStatus());
  }

  @override
  void initState() {
    loadOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: _isPageLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<OrderProvider>(
              builder: (context, orderData, child) => ListView.builder(
                itemBuilder: (ctx, index) {
                  return OrderItem(orderData.orders[index]);
                },
                itemCount: orderData.orders.length,
              ),
            ),
    );
  }
}
