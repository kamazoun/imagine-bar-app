import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/food.dart';
import 'package:imagine_bar/screens/widgets/selected_item_text.dart';

class SelectedPortionItem extends StatelessWidget {
  const SelectedPortionItem({
    Key key,
    this.condiment,
    this.quantity,
  }) : super(key: key);
  final Condiment condiment;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    return ListTile(
      title: Text(condiment.name + ' ($quantity)'),
      subtitle: Text('Total: ¢${condiment.cost * quantity}'),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          foodController.increasePortions(condiment);
        },
      ),
      leading: IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () {
          foodController.decreasePortions(condiment);
        },
      ),
    );
  }
}
