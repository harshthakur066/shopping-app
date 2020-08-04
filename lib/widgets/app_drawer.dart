import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome!'),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).accentColor,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 28,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              size: 28,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
