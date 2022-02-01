import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/foodController.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/food.dart';

class FoodListing extends StatelessWidget {
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
    List<Food> foods = foodController.foods;
    final List<DataRow> r = [];
    for (var food in foods) {
      r.add(DataRow(cells: [
        DataCell(Text(food.name)),
        DataCell(Text(localizedFoodCategory[food.category])),
        DataCell(Column(
          children: food.portions.entries
              .map((MapEntry<Condiment, int> e) =>
                  Text('${e.key.name} : ${e.value}'))
              .toList(),
        )),
        DataCell(Text('¢${food.cost}'), showEditIcon: true, onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => null));
        }),
      ]));
    }
    return r;
  }
}
