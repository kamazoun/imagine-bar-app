import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/models/order.dart';
import 'package:imagine_bar/screens/widgets/order_drinks_column.dart';
import 'package:imagine_bar/screens/widgets/order_foods_column.dart';

class WaitersTableSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();
    return FutureBuilder<List<Order>>(
        future: orderController.getDateOrders(),
        builder: (_, AsyncSnapshot<List<Order>> futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.done) {
            return Flexible(
              flex: 7,
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortColumnIndex: 1,
                    sortAscending: false,
                    headingTextStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blueGrey),
                    columns: [
                      DataColumn(label: Text('Waiter')),
                      DataColumn(
                          label: Text('drink orders',
                              overflow: TextOverflow.ellipsis)),
                      DataColumn(
                          label: Text('food orders',
                              overflow: TextOverflow.ellipsis)),
                      DataColumn(
                          label:
                              Text('total', overflow: TextOverflow.ellipsis)),
                      DataColumn(
                          label: Text('time', overflow: TextOverflow.ellipsis)),
                    ],
                    rows: _buildWaiterDataRows(context, futureSnapshot.data),
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  List<DataRow> _buildWaiterDataRows(context, List<Order> orders) {
    final List<DataRow> r = [];

    for (Order order in orders) {
      r.add(DataRow(cells: [
        DataCell(Text(order.waiterName)),
        DataCell(OrderDrinksColumn(
          order: order,
        )),
        DataCell(OrderFoodsColumn(
          order: order,
        )),
        DataCell(Text('¢${order.total}')),
        DataCell(Text('${order.at.toLocal()}')),
      ]));
    }

    return r;
  }
}
