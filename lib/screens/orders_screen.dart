import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  Future<void> _fetch() async {
    await Provider.of<Orders>(context, listen: false).fetchOrders();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _isLoading = true;
    _fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _fetch,
              child: ListView.builder(
                itemBuilder: (ctx, i) => OrderItem(
                  orderData.orders[i],
                ),
                itemCount: orderData.orders.length,
              ),
            ),
    );
  }
}
