import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/models/order.dart';

class Orders extends StatelessWidget {
  const Orders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder<QuerySnapshot<Order>>(
        stream: orderController.ordersStream(),
        builder: (_, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.none ||
              streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final QuerySnapshot querySnapshot = streamSnapshot.data;
          return ListView.builder(itemBuilder: (_, index) {
            return ListTile(
              title: Text('${querySnapshot.docs[index].data()}'),
            );
          });
          return Container();
        },
      ),
    );
  }
}
