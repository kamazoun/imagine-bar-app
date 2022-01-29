import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/foodController.dart';
import 'package:imagine_bar/models/drink.dart';

class CreateDrink extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Drink to Inventory'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () => createItem(context, foodController))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5, horizontal: MediaQuery.of(context).size.width / 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PopupMenuButton(
                child: SelectedItemText(),
                itemBuilder: (context) {
                  return buildPopUpMenu();
                },
                onSelected: (val) {
                  foodController.setSelectedDrinkCategory(val);
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
                controller: stockController,
                decoration: InputDecoration(
                    labelText: 'Enter the initial number of item in the stock'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: priceController,
                decoration: InputDecoration(
                    labelText: 'Enter the price of the item',
                    prefixIcon: Icon(Icons.money)),
              ),
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
    );
  }

  createItem(context, FoodController foodController) {
    if (nameController.text.isEmpty ||
        stockController.text.isEmpty ||
        priceController.text.isEmpty) {
      return;
    }

    for (var drink in foodController.drinks) {
      if (drink.name == nameController.text.trim()) {
        return;
      }
    }

    final newItem = Drink(
        cost: double.parse(priceController.text),
        stock: int.parse(stockController.text.trim()),
        time: DateTime.now(),
        name: nameController.text.trim(),
        category: foodController.selectedDrinkCategory);

    foodController.createDrink(newItem);

    Navigator.pop(context);
  }

  List<PopupMenuItem> buildPopUpMenu() {
    final List<PopupMenuItem> r = [];

    for (var item in DrinkCategory.values) {
      final name = localizedDrinkCategory[item];
      r.add(
        PopupMenuItem(
          child: Text(name),
          value: item,
        ),
      );
    }
    return r;
  }
}

class SelectedItemText extends StatelessWidget {
  const SelectedItemText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodController>(
      builder: (interface) {
        return Text(
          localizedDrinkCategory[interface.selectedDrinkCategory],
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              shadows: [
                Shadow(
                    color: Colors.grey, blurRadius: 5, offset: Offset(-2, -1))
              ],
              decoration: TextDecoration.underline),
        );
      },
    );
  }
}
