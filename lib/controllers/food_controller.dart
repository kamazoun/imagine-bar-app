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
  final RxList<Drink> _searchedDrinks = RxList<Drink>([]);
  RxList<Condiment> _condiments = RxList<Condiment>([]);
  RxList<Food> _foods = RxList<Food>([]);

  List<Drink> get drinks => _drinks;
  List<Drink> get searchedDrinks => _searchedDrinks;
  List<Condiment> get condiments => _condiments;
  List<Food> get foods => _foods;

  DrinkCategory selectedDrinkCategory = DrinkCategory.values[0];
  FoodCategory selectedFoodCategory = FoodCategory.values[0];
  Map<Condiment, int> portions = {};

  FoodController() {
    setAllDrinks();
    setAllCondiments();
    setAllFoods();
  }

  setAllDrinks() async {
    final d = await DrinkFirestore.getAllDrinks();
    _drinks.assignAll(d);
    _searchedDrinks.assignAll(d);
  }

  setAllCondiments() async {
    final c = await CondimentFirestore.getAllCondiments();
    _condiments.assignAll(c);
  }

  setAllFoods() async {
    final f = await FoodFirestore.getAllFoods();
    _foods.assignAll(f);
  }

  Future<List<Drink>> getEmptyDrinks() async {
    // Maybe take from _drinks? But what if meanwhile some drinks are updated?
    final drinks = await DrinkFirestore.getEmptyDrinks();
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

  createFood(Food food) async {
    final DocumentReference r = await FoodFirestore.createFood(food);
    _foods.add(food.copyWith(id: r.id));

    update(); // Surprisingly without that, after adding GetX does not automatically refresh.
  }

  void setSelectedDrinkCategory(category) {
    selectedDrinkCategory = category;
    update();
  }

  void setSelectedFoodCategory(category) {
    selectedFoodCategory = category;
    update();
  }

  void setPortions(val) {
    portions.addAll({val as Condiment: 1});
    update();
  }

  void assignPortions(newPortions) {
    portions = newPortions;
    update();
  }

  void increasePortions(Condiment val) {
    if (portions.containsKey(val)) {
      portions[val] += 1;
      update();
    }
  }

  void decreasePortions(Condiment val) {
    if (portions.containsKey(val)) {
      portions[val] -= 1;
      if (portions[val] <= 0) {
        portions.remove(val);
      }
      update();
    }
  }

  void updateDrink(Drink drink) {
    DrinkFirestore.updateDrink(drink);

    _drinks.removeWhere((element) => element.id == drink.id);
    _drinks.add(drink);
    update();
  }

  void updateFood(Food food) {
    FoodFirestore.updateFood(food);

    _foods.removeWhere((element) => element.id == food.id);
    _foods.add(food);
    update();
  }

  void setSearchedDrinks({String value}) {
    if (null == value || value.isEmpty) {
      _searchedDrinks.assignAll(drinks);
      update();
      return;
    }
    _searchedDrinks.assignAll(drinks
        .where((element) =>
            element.name.toLowerCase().contains(value.trim().toLowerCase()))
        .toList());
    update();
  }

  void updateCondiment(Condiment condiment) {
    CondimentFirestore.updateCondiment(condiment);

    _condiments.removeWhere((element) => element.id == condiment.id);
    _condiments.add(condiment);
    update();
  }

  returnDrink(String id, int quantity) {
    DrinkFirestore.increaseDrinkStock(id, quantity);
    final drink = _drinks.firstWhereOrNull((p0) => p0.id == id);
    if (null == drink) {
      return;
    }
    drinks.remove(drink);
    drinks.add(drink.copyWith(stock: drink.stock + quantity));

    update();
  }

  returnCondiment(String id, int quantity) {
    CondimentFirestore.increaseCondimentStock(id, quantity);
    final condiment = _condiments.firstWhereOrNull((p0) => p0.id == id);
    if (null == condiment) {
      return;
    }
    condiments.remove(condiment);
    condiments.add(condiment.copyWith(stock: condiment.stock + quantity));

    update();
  }
}
