import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/models/order.dart';

class OrderDrinksColumn extends StatelessWidget {
  const OrderDrinksColumn({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: order.drinkItems.keys
          .map((key) => Text(
              '${order.drinkItems[key]} ${foodController.drinks.firstWhereOrNull((element) => element.id == key).name}'))
          .toList(),
    );
  }
}
