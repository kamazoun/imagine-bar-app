import 'package:imagine_bar/models/condiment.dart';

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

  Food.fromJson(Map<String, Object> json)
      : this(
            id: json['id'] as String,
            name: json['name'] as String,
            category: FoodCategory.values[(json['category'])],
            cost: json['cost'],
            time: DateTime.fromMillisecondsSinceEpoch(json['time']),
            portions: json['portions']);

  Map<String, Object> toJson() {
    return {
      //'id': id,
      'name': name,
      'category': category.index,
      'cost': cost,
      'time': time.millisecondsSinceEpoch,
      'portions': portions
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
}
