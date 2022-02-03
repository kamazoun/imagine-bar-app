import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/drink.dart';
import 'package:imagine_bar/screens/edit_drinks.dart';

class DrinkListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetX<FoodController>(
        builder: (foodController) => DataTable(
          headingTextStyle:
              TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
          columns: [
            DataColumn(label: Text('Item')),
            DataColumn(label: Text('Category')),
            DataColumn(
                label: Text('Stock', overflow: TextOverflow.ellipsis)), // Stock

            DataColumn(label: Text('Price', overflow: TextOverflow.ellipsis)),
          ],
          rows: buildDataRows(context, foodController),
        ),
      ),
    ));
  }

  List<DataRow> buildDataRows(context, FoodController foodController) {
    List<Drink> drinks = foodController.drinks;
    final List<DataRow> r = [];
    for (var drink in drinks) {
      r.add(DataRow(cells: [
        DataCell(Text(drink.name)),
        DataCell(Text(localizedDrinkCategory[drink.category])),
        DataCell(Text('${drink.stock}')),
        DataCell(Text('¢${drink.cost}'), showEditIcon: true, onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditDrink(
                        drink: drink,
                      )));
        }),
      ]));
    }
    return r;
  }
}
