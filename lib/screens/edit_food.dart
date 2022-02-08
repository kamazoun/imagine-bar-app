import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/food.dart';
import 'package:imagine_bar/screens/widgets/selected_item_text.dart';
import 'package:imagine_bar/screens/widgets/selected_portion_item.dart';

class EditFood extends StatefulWidget {
  final Food food;

  EditFood({this.food});

  @override
  _EditFoodState createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  Food food;
  @override
  void initState() {
    super.initState();
    food = widget.food;
    if (food != null) {
      nameController.text = food.name;
      priceController.text = food.cost.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    if (food != null) {
      foodController.setSelectedFoodCategory(food.category);
      foodController.assignPortions(food.portions);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${food?.name ?? 'food'}'),
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
                SizedBox(
                  height: 40,
                  child: PopupMenuButton(
                    child: Text(food?.name ?? 'Select Food to Edit'),
                    itemBuilder: (context) {
                      return buildFoodsList(foodController);
                    },
                    onSelected: (val) {
                      setState(() {
                        food = val;
                        if (food != null) {
                          nameController.text = food.name;
                          priceController.text = food.cost.toString();
                          foodController.setSelectedFoodCategory(food.category);
                          foodController.assignPortions(food.portions);
                        }
                      });
                    },
                  ),
                ),
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

    final newItem = food.copyWith(
        cost: double.parse(priceController.text),
        name: nameController.text.trim(),
        portions: foodController.portions,
        category: foodController.selectedFoodCategory,
        time: DateTime.now());

    foodController.updateFood(newItem);

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

  List<PopupMenuItem> buildFoodsList(FoodController foodController) {
    final List<PopupMenuItem> r = [];

    for (var item in foodController.foods) {
      final name = item.name;
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
