import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/products_grid_view.dart';
import '../widgets/badge.dart.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

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
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((_) {
  //     Provider.of<Products>(context).fetchProducts();
  //     print('initState');
  //     print(Provider.of<Products>(
  //       context,
  //     ).items);
  //   });
  //   super.initState();
  // }

  // BOTH ARE SAME

  @override
  void didChangeDependencies() {
    final products = Provider.of<Products>(context);
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      products.fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
          _isInit = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
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
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await products.fetchProducts();
              },
              child: ProductGridView(_showOnlyFav)),
    );
  }
}
