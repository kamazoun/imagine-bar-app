import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/food.dart';
import 'package:imagine_bar/screens/widgets/selected_item_text.dart';
import 'package:imagine_bar/screens/widgets/selected_portion_item.dart';

class CreateFood extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Food to the menu'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () => createItem(context, foodController))
        ],
      ),
      body: GetBuilder<FoodController>(
        builder: (FoodController foodController) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: MediaQuery.of(context).size.width / 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PopupMenuButton(
                  child: SelectedItemText(
                    isDrink: false,
                  ),
                  itemBuilder: (context) {
                    return buildPopUpMenu();
                  },
                  onSelected: (val) {
                    foodController.setSelectedFoodCategory(val);
                  },
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Please enter the name of new item'),
                ),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: priceController,
                  decoration: InputDecoration(
                      labelText: 'Enter the price of the item',
                      prefixIcon: Icon(Icons.money)),
                ),
                PopupMenuButton(
                  onSelected: (val) {
                    foodController.setPortions(
                        val); //portions.addAll({val as Condiment: 1});
                  },
                  itemBuilder: (context) {
                    return _buildCheckedPopUpMenu(foodController);
                  },
                  child: OutlinedButton(
                    child: Text(
                        'Select all the condiments that enter in the preparation of this food'),
                    onPressed: null,
                  ),
                ),
                ...foodController.portions.entries.map(
                    (MapEntry<Condiment, int> e) => SelectedPortionItem(
                        condiment: e.key, quantity: e.value)),
                const Divider(
                  indent: 25.0,
                  endIndent: 25.0,
                ),
                OutlinedButton(
                    onPressed: () => createItem(context, foodController),
                    child: Text('Ok'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  createItem(context, FoodController foodController) {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      return;
    }

    for (var food in foodController.foods) {
      if (food.name == nameController.text.trim()) {
        return;
      }
    }

    final newItem = Food(
        cost: double.parse(priceController.text),
        name: nameController.text.trim(),
        portions: foodController.portions,
        category: foodController.selectedFoodCategory,
        time: DateTime.now());

    foodController.createFood(newItem);

    Navigator.pop(context);
  }

  List<PopupMenuItem> buildPopUpMenu() {
    final List<PopupMenuItem> r = [];

    for (var item in FoodCategory.values) {
      final name = localizedFoodCategory[item];
      r.add(
        PopupMenuItem(
          child: Text(name),
          value: item,
        ),
      );
    }
    return r;
  }

  List<PopupMenuItem> _buildCheckedPopUpMenu(FoodController foodController) {
    final List<PopupMenuItem> r = [];

    for (Condiment item in foodController.condiments) {
      r.add(
        CheckedPopupMenuItem(
          child: Text(item.name),
          value: item,
          checked: foodController.portions.containsKey(item),
        ),
      );
    }

    return r;
  }
}
