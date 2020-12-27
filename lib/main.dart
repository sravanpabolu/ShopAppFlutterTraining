import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_training/providers/auth.dart';
import 'package:shop_app_training/providers/cart.dart';
import 'package:shop_app_training/providers/orders.dart';
import 'package:shop_app_training/providers/products.dart';
import 'package:shop_app_training/screens/auth_screen.dart';
import 'package:shop_app_training/screens/cart_screen.dart';
import 'package:shop_app_training/screens/edit_product_screen.dart';
import 'package:shop_app_training/screens/orders_screen.dart';
import 'package:shop_app_training/screens/product_detail_screen.dart';
import 'package:shop_app_training/screens/products_overview_screen.dart';
import 'package:shop_app_training/screens/splash_screen.dart';
import 'package:shop_app_training/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //register provider
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                previousProducts == null ? [] : previousProducts.items,
                auth.userId),
            create: null,
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                previousOrders == null ? [] : previousOrders.orders,
                auth.token,
                auth.userId),
            create: null,
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              // fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
                  ),
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
            },
          ),
        ));
  }
}
