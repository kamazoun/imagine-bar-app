import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/models/drink.dart';
import 'package:imagine_bar/models/food.dart';
import 'package:imagine_bar/models/order.dart';

class CancelOrder extends StatefulWidget {
  final Order order;

  CancelOrder({this.order});

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  final Map<String, int> drinksRemoval = {};
  final Map<String, int> foodsRemoval = {};

  @override
  void initState() {
    super.initState();

    if (null != widget.order) {
      drinksRemoval.assignAll(widget.order.drinkItems);
      foodsRemoval.assignAll(widget.order.foodItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Select elements to remove from order'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: Get.width / 5),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                _buildOrderItems(widget.order),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await orderController.cancelOrder(
                        widget.order, drinksRemoval, foodsRemoval);

                    Get.back();
                  },
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  label: Text('Remove from Order')),
            ),
          ],
        ),
      ),
    );
  }

  _buildOrderItems(Order order) {
    final FoodController foodController = Get.find<FoodController>();
    final List<Widget> r = [];

    for (final entry in order.foodItems.entries) {
      final Food food = foodController.foods
          .firstWhereOrNull((element) => element.id == entry.key);

      if (null == food) {
        continue;
      }

      r.add(
        ListTile(
          leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: foodsRemoval[food.id] > 0
                ? () {
                    setState(() {
                      foodsRemoval[food.id] -= 1;
                    });
                  }
                : null,
          ),
          title: Text(food.name),
          subtitle: Text(
              'Removing ${foodsRemoval[food.id]} out of ${order.foodItems[food.id]} foods'),
          trailing: IconButton(
            icon: Icon(Icons.remove),
            onPressed: foodsRemoval[food.id] < order.foodItems[food.id]
                ? () {
                    setState(() {
                      foodsRemoval[food.id] += 1;
                    });
                  }
                : null,
          ),
        ),
      );
    }
    for (final entry in order.drinkItems.entries) {
      final Drink drink = foodController.drinks
          .firstWhereOrNull((element) => element.id == entry.key);

      if (null == drink) {
        continue;
      }

      r.add(ListTile(
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: drinksRemoval[drink.id] > 0
              ? () {
                  setState(() {
                    drinksRemoval[drink.id] -= 1;
                  });
                }
              : null,
        ),
        title: Text(drink.name),
        subtitle: Text(
            'Removing ${drinksRemoval[drink.id]} out of ${order.drinkItems[drink.id]} drinks'),
        trailing: IconButton(
          icon: Icon(Icons.remove),
          onPressed: drinksRemoval[drink.id] < order.drinkItems[drink.id]
              ? () {
                  setState(() {
                    drinksRemoval[drink.id] += 1;
                  });
                }
              : null,
        ),
      ));
    }
    return r;
  }
}
