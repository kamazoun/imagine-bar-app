import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/drink.dart';
import 'package:imagine_bar/screens/widgets/selected_item_text.dart';

class EditDrink extends StatefulWidget {
  final Drink drink;

  EditDrink({Key key, this.drink}) : super(key: key);

  @override
  State<EditDrink> createState() => _EditDrinkState();
}

class _EditDrinkState extends State<EditDrink> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  Drink drink;
  @override
  void initState() {
    super.initState();
    drink = widget.drink;
    if (drink != null) {
      nameController.text = drink.name;
      stockController.text = drink.stock.toString();
      priceController.text = drink.cost.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${drink?.name ?? 'drink'}'),
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
              SizedBox(
                height: 40,
                child: PopupMenuButton(
                  child: Text(drink?.name ?? 'Select Drink to Edit'),
                  itemBuilder: (context) {
                    return buildDrinksList(foodController);
                  },
                  onSelected: (val) {
                    setState(() {
                      drink = val;
                      if (drink != null) {
                        nameController.text = drink.name;
                        stockController.text = drink.stock.toString();
                        priceController.text = drink.cost.toString();
                        foodController.setSelectedDrinkCategory(drink.category);
                      }
                    });
                  },
                ),
              ),
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
                decoration:
                    InputDecoration(labelText: 'Please enter the new name'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: stockController,
                decoration: InputDecoration(
                    labelText: 'Enter the new quantity in stock'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: priceController,
                decoration: InputDecoration(
                    labelText: 'Enter the new price',
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

    final newItem = drink.copyWith(
        cost: double.parse(priceController.text),
        stock: int.parse(stockController.text.trim()),
        time: DateTime.now(),
        name: nameController.text.trim(),
        category: foodController.selectedDrinkCategory);

    foodController.updateDrink(newItem);

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

  List<PopupMenuItem> buildDrinksList(FoodController foodController) {
    final List<PopupMenuItem> r = [];

    for (var item in foodController.drinks) {
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
}
