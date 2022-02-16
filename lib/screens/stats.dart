import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/screens/widgets/graphical_stats.dart';
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
