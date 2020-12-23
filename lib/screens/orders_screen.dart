import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_training/providers/orders.dart' show Orders;
import 'package:shop_app_training/widgets/app_drawer.dart';
import 'package:shop_app_training/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

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
          future: _ordersFuture,
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
