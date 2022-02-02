import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/drink.dart';
import 'package:imagine_bar/models/food.dart';

class SelectedItemText extends StatelessWidget {
  const SelectedItemText({
    Key key,
    this.isDrink = true,
  }) : super(key: key);

  final isDrink;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodController>(
      builder: (interface) {
        return Text(
          isDrink
              ? localizedDrinkCategory[interface.selectedDrinkCategory]
              : localizedFoodCategory[interface.selectedFoodCategory],
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
