import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/screens/widgets/items_table_summary.dart';
import 'package:imagine_bar/screens/widgets/select_range_date.dart';
import 'package:imagine_bar/screens/widgets/waiters_table_summary.dart';

List colors = [Colors.pink, Colors.blue, Colors.accents];

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Day-range Stats'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.money_rounded)),
              Tab(icon: Icon(Icons.supervised_user_circle_sharp)),
              Tab(icon: Icon(Icons.restaurant_menu)),
            ],
          ),
        ),
        body: GetBuilder<OrderController>(
          builder: (orderController) => TabBarView(children: [
            GraphicalStats(),
            Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 1,
                  child: SelectRangeDate(),
                ),
                WaitersTableSummary(true),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 1,
                  child: SelectRangeDate(),
                ),
                ItemsTableSummary(true),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class GraphicalStats extends StatelessWidget {
  const GraphicalStats({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50, child: SelectRangeDate()),
            Text(
                'Quantity of items sold: ${orderController.getTotalQuantityOfDrinksFoodsSold(isRange: true)[0] + orderController.getTotalQuantityOfDrinksFoodsSold(isRange: true)[1]}'),
            SizedBox(
              width: kIsWeb ? Get.width / 2 : Get.width - 10,
              height: kIsWeb ? Get.width / 2 : Get.width - 10,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 5,
                  sections: [
                    PieChartSectionData(
                        radius: kIsWeb
                            ? (Get.width / 4) - 15
                            : (Get.width / 2) - 10,
                        color: Colors.yellow,
                        title:
                            'Drinks(${orderController.getTotalQuantityOfDrinksFoodsSold(isRange: true)[0]})',
                        value:
                            orderController.getTotalQuantityOfDrinksFoodsSold(
                                    isRange: true)[0] *
                                1.0),
                    PieChartSectionData(
                        radius: kIsWeb
                            ? (Get.width / 4) - 15
                            : (Get.width / 2) - 10,
                        color: Colors.red,
                        title:
                            'Foods (${orderController.getTotalQuantityOfDrinksFoodsSold(isRange: true)[1]})',
                        value:
                            orderController.getTotalQuantityOfDrinksFoodsSold(
                                    isRange: true)[1] *
                                1.0),
                  ],
                ),
              ),
            ),
            const Divider(),
            Text(
                'Different drinks sold: ${orderController.getEachDrinksSold(isRange: true).length}'),
            SizedBox(
              width: kIsWeb ? Get.width / 2 : Get.width - 10,
              height: kIsWeb ? Get.width / 2 : Get.width - 10,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 5,
                  sections: _buildDrinksSectionData(orderController),
                ),
              ),
            ),
            const Divider(),
            Text(
                'Different meals sold: ${orderController.getEachFoodsSold(isRange: true).length}'),
            SizedBox(
              width: kIsWeb ? Get.width / 2 : Get.width - 10,
              height: kIsWeb ? Get.width / 2 : Get.width - 10,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 5,
                  sections: _buildFoodsSectionData(orderController),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildDrinksSectionData(
      OrderController orderController) {
    List<PieChartSectionData> r = [];

    for (var entry
        in orderController.getEachDrinksSold(isRange: true).entries) {
      r.add(PieChartSectionData(
          radius: kIsWeb ? (Get.width / 4) - 15 : (Get.width / 2) - 10,
          color: Colors.accents[Random().nextInt(Colors.accents.length)],
          value: entry.value.toDouble(),
          title: entry.key.name + '(${entry.value})'));
    }
    return r;
  }

  List<PieChartSectionData> _buildFoodsSectionData(
      OrderController orderController) {
    List<PieChartSectionData> r = [];

    for (var entry in orderController.getEachFoodsSold(isRange: true).entries) {
      r.add(PieChartSectionData(
          radius: kIsWeb ? (Get.width / 4) - 15 : (Get.width / 2) - 10,
          color: Colors.accents[Random().nextInt(Colors.accents.length)],
          value: entry.value.toDouble(),
          title: entry.key.name + '(${entry.value})'));
    }
    return r;
  }
}
