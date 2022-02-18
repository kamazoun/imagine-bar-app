import 'package:flutter/material.dart';
import 'package:imagine_bar/models/order.dart';

class CancelOrder extends StatelessWidget {
  final Order order;

  CancelOrder({this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text('Remove the individual items from your order'),
            ),
            SliverList(
                delegate:
                    SliverChildListDelegate.fixed(_buildOrderItems(order)))
          ],
        ));
  }

  _buildOrderItems(Order order) {}
}
