import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/screens/widgets/items_table_summary.dart';
import 'package:imagine_bar/screens/widgets/select_order_summary_date.dart';
import 'package:imagine_bar/screens/widgets/waiters_table_summary.dart';

class GraphicalSummary extends StatelessWidget {
  const GraphicalSummary({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50, child: SelectOrderSummaryDate()),
            Text(
                'Quantity of items sold that day: ${orderController.getTotalQuantityOfDrinksFoodsSold()[0] + orderController.getTotalQuantityOfDrinksFoodsSold()[1]}'),
            SizedBox(
              width: kIsWeb ? Get.width / 2 : Get.width - 10,
              height: kIsWeb ? Get.width / 2 : Get.width - 10,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                        radius: kIsWeb
                            ? (Get.width / 4) - 15
                            : (Get.width / 2) - 10,
                        color: Colors.yellow,
                        title:
                            'Drinks(${orderController.getTotalQuantityOfDrinksFoodsSold()[0]})',
                        value: orderController
                                .getTotalQuantityOfDrinksFoodsSold()[0] *
                            1.0),
                    PieChartSectionData(
                        radius: kIsWeb
                            ? (Get.width / 4) - 15
                            : (Get.width / 2) - 10,
                        color: Colors.red,
                        title:
                            'Foods (${orderController.getTotalQuantityOfDrinksFoodsSold()[1]})',
                        value: orderController
                                .getTotalQuantityOfDrinksFoodsSold()[1] *
                            1.0),
                  ],
                ),
              ),
            ),
            const Divider(),
            Text(
                'Different drinks sold that day: ${orderController.getEachDrinksSold().length}'),
            SizedBox(
              width: kIsWeb ? Get.width / 2 : Get.width - 10,
              height: kIsWeb ? Get.width / 2 : Get.width - 10,
              child: PieChart(
                PieChartData(
                  sections: _buildDrinksSectionData(orderController),
                ),
              ),
            ),
            const Divider(),
            Text(
                'Different meals sold that day: ${orderController.getEachFoodsSold().length}'),
            SizedBox(
              width: kIsWeb ? Get.width / 2 : Get.width - 10,
              height: kIsWeb ? Get.width / 2 : Get.width - 10,
              child: PieChart(
                PieChartData(
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

    for (var entry in orderController.getEachDrinksSold().entries) {
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

    for (var entry in orderController.getEachFoodsSold().entries) {
      r.add(PieChartSectionData(
          radius: kIsWeb ? (Get.width / 4) - 15 : (Get.width / 2) - 10,
          color: Colors.accents[Random().nextInt(Colors.accents.length)],
          value: entry.value.toDouble(),
          title: entry.key.name + '(${entry.value})'));
    }
    return r;
  }
}
