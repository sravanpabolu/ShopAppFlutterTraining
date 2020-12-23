import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_training/providers/orders.dart' show Orders;
import 'package:shop_app_training/widgets/app_drawer.dart';
import 'package:shop_app_training/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print("building orders");
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                //Error Handling
                return Center(child: Text('Some Error'));
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (context, index) => OrderItem(
                      orderData.orders[index],
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
