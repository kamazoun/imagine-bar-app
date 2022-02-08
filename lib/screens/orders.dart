import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/models/order.dart';
import 'package:imagine_bar/screens/item_listing.dart';
import 'package:imagine_bar/screens/widgets/main_drawer.dart';
import 'package:imagine_bar/screens/widgets/order_drinks_column.dart';
import 'package:imagine_bar/screens/widgets/order_foods_column.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool isTable = false;

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => ItemListing());
              },
              icon: const Icon(Icons.inventory)),
          IconButton(
              onPressed: () {
                setState(() {
                  isTable = !isTable;
                });
              },
              icon: const Icon(Icons.change_circle))
        ],
      ),
      body: GetBuilder<OrderController>(
        builder: (orderController) => StreamBuilder<QuerySnapshot<Order>>(
          stream: orderController.ordersStream(),
          builder: (_, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final QuerySnapshot querySnapshot = streamSnapshot.data;
            return isTable
                ? Padding(
                    padding: kIsWeb
                        ? EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: Get.width / 15)
                        : const EdgeInsets.all(1.0),
                    child: Container(
                      margin: kIsWeb
                          ? const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15)
                          : const EdgeInsets.all(1.0),
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          return OrderListItem(
                            order: querySnapshot.docs[index].data(),
                          );
                        },
                        itemCount: querySnapshot.docs.length,
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 1,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: kIsWeb
                        ? const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30)
                        : const EdgeInsets.all(1.0),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Waiter Name')),
                              DataColumn(label: Text('Drink Orders')),
                              DataColumn(label: Text('Food Orders')),
                              DataColumn(label: Text('Total')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Date')),
                            ],
                            rows: _buildDataRows(context, querySnapshot.docs),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  List<DataRow> _buildDataRows(context, List<QueryDocumentSnapshot> docs) {
    final List<DataRow> r = [];
    for (var q in docs) {
      Order order = q.data();
      r.add(DataRow(cells: [
        DataCell(Text(order.waiterName)),
        DataCell(
          OrderDrinksColumn(order: order),
        ),
        DataCell(
          OrderFoodsColumn(order: order),
        ),
        DataCell(Text('¢${order.total}')),
        DataCell(PopupMenuButton(
          onSelected: (String val) {
            Order newItem;
            if (val == 'Paid') {
              newItem = order.copyWith(paid: true, served: true);
            } else if (val == 'Served') {
              newItem = order.copyWith(paid: false, served: true);
            } else {
              newItem = order.copyWith(paid: false, served: false);
            }
            final OrderController orderController = Get.find<OrderController>();

            orderController.updateOrder(newItem);
          },
          itemBuilder: (_) => ['Paid', 'Served', 'Not Served']
              .map((e) => PopupMenuItem(
                    child: Text(e),
                    value: e,
                  ))
              .toList(),
          child: Text(
              '${order.paid ? 'Paid' : order.served ? 'Served' : 'Not served'}'),
        )),
        DataCell(Text('${order.at.toLocal()}')),
      ]));
    }
    return r;
  }
}

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(order.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        final OrderController orderController = Get.find<OrderController>();

        if (!order.served) {
          final newItem = order.copyWith(served: true);

          orderController.updateOrder(newItem);
        } else if (!order.paid) {
          final newItem = order.copyWith(paid: true);

          orderController.updateOrder(newItem);
        }
      },
      child: Card(
        elevation: 0.1,
        child: ListTile(
          onTap: null,
          title: Center(child: Text(order.waiterName)),
          leading: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              '¢${order.total}',
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          trailing: TextButton(
              onPressed: () {},
              child: Text(
                  '${order.paid ? 'Paid' : order.served ? 'Served' : 'Not served'}')),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderDrinksColumn(order: order),
                VerticalDivider(width: 10),
                OrderFoodsColumn(order: order),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
