import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/orders.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          // create: (context) => Products(),
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          // create: (context) => Products(),
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          // create: (context) => Products(),
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.pinkAccent,
          fontFamily: 'Lato',
        ),
        home: ProductOvervireScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
