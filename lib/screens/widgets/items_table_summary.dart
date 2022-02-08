import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/models/drink.dart';
import 'package:imagine_bar/models/food.dart';
import 'package:imagine_bar/models/order.dart';

class ItemsTableSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();
    return FutureBuilder<List<Order>>(
        future: orderController.getRangeOrders(),
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
                      DataColumn(label: Text('Items')),
                      DataColumn(
                          label: Text('Opening stock',
                              overflow: TextOverflow.ellipsis)),
                      DataColumn(
                          label: Text('Number of sales',
                              overflow: TextOverflow.ellipsis)),
                      DataColumn(
                          label: Text('Remaining Stock',
                              overflow: TextOverflow.ellipsis)),
                      DataColumn(
                          label: Text('Total cost',
                              overflow: TextOverflow.ellipsis)),
                    ],
                    rows: _buildItemsDataRows(context, futureSnapshot.data),
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  List<DataRow> _buildItemsDataRows(context, List<Order> orders) {
    final List<DataRow> r = [];
    final FoodController foodController = Get.find<FoodController>();

    Map<Drink, int> drinks = {};
    Map<Food, int> foods = {};

    for (Order order in orders) {
      for (var entry in order.drinkItems.entries) {
        final Drink keyDrink = foodController.drinks
            .firstWhereOrNull((element) => element.id == entry.key);
        if (drinks.keys.contains(keyDrink)) {
          drinks[keyDrink] += entry.value;
        } else {
          drinks.addAll({keyDrink: entry.value});
        }
      }

      for (var entry in order.foodItems.entries) {
        final Food keyFood = foodController.foods
            .firstWhereOrNull((element) => element.id == entry.key);
        if (foods.keys.contains(keyFood)) {
          foods[keyFood] += entry.value;
        } else {
          foods.addAll({keyFood: entry.value});
        }
      }
    }

    for (var entry in drinks.entries) {
      r.add(DataRow(cells: [
        DataCell(Text(entry.key.name)),
        DataCell(Text('${entry.value + entry.key.stock}')),
        DataCell(Text('${entry.value}')),
        DataCell(Text('${entry.key.stock}')),
        DataCell(Text('¢${entry.value * entry.key.cost}')),
      ]));
    }

    for (var entry in foods.entries) {
      final int remaining = _calculateMinPortions(entry.key);
      r.add(DataRow(cells: [
        DataCell(Text(entry.key.name)),
        DataCell(Text('${entry.value + remaining}')),
        DataCell(Text('${entry.value}')),
        DataCell(Text('$remaining')),
        DataCell(Text('¢${entry.value * entry.key.cost}')),
      ]));
    }

    return r;
  }

  int _calculateMinPortions(Food food) {
    double mini = 100000000.0;
    for (var entry in food.portions.entries) {
      mini = min(mini, entry.key.stock / entry.value);
    }
    return mini.toInt();
  }
}
