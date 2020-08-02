import 'package:flutter/material.dart';

import '../widgets/products_grid_view.dart';

class ProductOvervireScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopify',
        ),
      ),
      body: ProductGridView(),
    );
  }
}
