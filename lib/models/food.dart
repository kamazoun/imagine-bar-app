import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/models/condiment.dart';

final localizedFoodCategory = {
  FoodCategory.defaultCategory: 'default',
};

enum FoodCategory { defaultCategory }

class Food {
  final String id;
  final String name;
  final FoodCategory category;
  final double cost;
  final DateTime time;
  final Map<Condiment, int>
      portions; // id of item and quantity. Ex meat: 3 portions

  Food(
      {this.id, this.name, this.category, this.cost, this.time, this.portions});

  Food.fromJson(String id, Map<String, Object> json)
      : this(
            id: id,
            name: json['name'] as String,
            category: FoodCategory.values[(json['category'])],
            cost: json['cost'],
            time: DateTime.fromMillisecondsSinceEpoch(json['time']),
            portions: _buildPortions(json['portions'] as Map<String, dynamic>));

  Map<String, Object> toJson() {
    Map<String, dynamic> mappedPortions = {};
    for (MapEntry<Condiment, int> entry in portions.entries) {
      mappedPortions.addAll({entry.key.id: entry.value});
    }
    return {
      //'id': id,
      'name': name,
      'category': category.index,
      'cost': cost,
      'time': time.millisecondsSinceEpoch,
      'portions': mappedPortions,
    };
  }

  Food copyWith({id, name, category, cost, time, stock, portions}) {
    return Food(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        cost: cost ?? this.cost,
        time: time ?? this.time,
        portions: portions ?? this.portions);
  }

  static Map<Condiment, int> _buildPortions(Map<String, dynamic> data) {
    final FoodController foodController = Get.find<FoodController>();

    Map<Condiment, int> r = {};
    for (MapEntry<String, dynamic> entry in data.entries) {
      final Condiment c = foodController.condiments
          .firstWhereOrNull((element) => element.id == entry.key.trim());

      if (null != c) {
        r.addAll({c: entry.value as int});
      }
    }
    return r;
  }
}
