import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/foodController.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/drink.dart';

class CreateCondiment extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Condiment to the Kitchen'),
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

    for (var condiment in foodController.condiments) {
      if (condiment.name == nameController.text.trim()) {
        return;
      }
    }

    final newItem = Condiment(
        cost: double.parse(priceController.text),
        stock: int.parse(stockController.text.trim()),
        name: nameController.text.trim());

    foodController.createCondiment(newItem);

    Navigator.pop(context);
  }
}
