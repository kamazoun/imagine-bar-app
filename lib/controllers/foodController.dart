import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/db/condiment_firestore.dart';
import 'package:imagine_bar/db/drink_firestore.dart';
import 'package:imagine_bar/db/food_firestore.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/drink.dart';
import 'package:imagine_bar/models/food.dart';

class FoodController extends GetxController {
  RxList<Drink> _drinks = RxList<Drink>([]);
  RxList<Condiment> _condiments = RxList<Condiment>([]);
  RxList<Food> _foods = RxList<Food>([]);

  List<Drink> get drinks => _drinks;
  List<Condiment> get condiments => _condiments;
  List<Food> get foods => _foods;

  DrinkCategory selectedDrinkCategory = DrinkCategory.values[0];

  FoodController() {
    setAllDrinks();
    setAllCondiments();
    setAllFoods();
  }

  setAllDrinks() async {
    final d = await DrinkFirestore.getAllDrinks();
    _drinks.setAll(0, d);
  }

  setAllCondiments() async {
    final c = await CondimentFirestore.getAllCondiments();
    _condiments.setAll(0, c);
  }

  setAllFoods() async {
    final f = await FoodFirestore.getAllFoods();
    _foods.setAll(0, f);
  }

  Future<List<Drink>> getEmptyDrinks() async {
    // Maybe take from _drinks? But what if meanwhile some drinks are updated?
    final drinks = await DrinkFirestore.getEmptyDrinks();
    //_drinks.setAll(0, d);
    return drinks;
  }

  createDrink(Drink drink) async {
    final DocumentReference r = await DrinkFirestore.createDrink(drink);
    _drinks.add(drink.copyWith(id: r.id));

    update(); // Surprisingly without that, after adding GetX does not automatically refresh.
  }

  createCondiment(Condiment condiment) async {
    final DocumentReference r =
        await CondimentFirestore.createCondiment(condiment);
    _condiments.add(condiment.copyWith(id: r.id));

    update(); // Surprisingly without that, after adding GetX does not automatically refresh.
  }

  void setSelectedDrinkCategory(category) {
    selectedDrinkCategory = category;
    update();
  }
}
