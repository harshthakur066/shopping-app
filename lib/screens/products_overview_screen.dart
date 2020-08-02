import 'package:flutter/material.dart';

import '../widgets/products_grid_view.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOvervireScreen extends StatefulWidget {
  @override
  _ProductOvervireScreenState createState() => _ProductOvervireScreenState();
}

class _ProductOvervireScreenState extends State<ProductOvervireScreen> {
  var _showOnlyFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopify',
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favorites',
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                  'All Items',
                ),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(
              Icons.more_vert,
            ),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFav = true;
                } else {
                  _showOnlyFav = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductGridView(_showOnlyFav),
    );
  }
}
