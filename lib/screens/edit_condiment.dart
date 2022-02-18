import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/screens/widgets/selected_item_text.dart';
import 'package:imagine_bar/screens/widgets/selected_portion_item.dart';

class EditCondiment extends StatefulWidget {
  final Condiment condiment;

  EditCondiment({this.condiment});

  @override
  _EditCondimentState createState() => _EditCondimentState();
}

class _EditCondimentState extends State<EditCondiment> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  Condiment condiment;
  @override
  void initState() {
    super.initState();
    condiment = widget.condiment;
    if (condiment != null) {
      nameController.text = condiment.name;
      priceController.text = condiment.cost.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${condiment?.name ?? 'condiment'}'),
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
                    child: Text(condiment?.name ?? 'Select Condiment to Edit'),
                    itemBuilder: (context) {
                      return buildCondimentsList(foodController);
                    },
                    onSelected: (val) {
                      setState(() {
                        condiment = val;
                        if (condiment != null) {
                          nameController.text = condiment.name;
                          priceController.text = condiment.cost.toString();
                        }
                      });
                    },
                  ),
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

    final newItem = condiment.copyWith(
        cost: double.parse(priceController.text),
        name: nameController.text.trim(),
        time: DateTime.now());

    foodController.updateCondiment(newItem);

    Navigator.pop(context);
  }

  List<PopupMenuItem> buildCondimentsList(FoodController foodController) {
    final List<PopupMenuItem> r = [];

    for (var item in foodController.condiments) {
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
