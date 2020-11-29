import 'package:flutter/material.dart';
import 'package:shop_app_training/screens/product_detail_screen.dart';
import 'package:shop_app_training/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        
      },
    );
  }
}
