final localizedDrinkCategory = {
  DrinkCategory.fresh_juice: 'Fresh Juice',
  DrinkCategory.wine: 'Wine',
  DrinkCategory.whisky: 'Whisky',
  DrinkCategory.others: 'Others',
  DrinkCategory.alcoholic: 'Alcoholic',
  DrinkCategory.non_alcoholic: 'Non Alcoholic',
  DrinkCategory.desserts: 'Desserts',
  DrinkCategory.sides: 'Sides',
  DrinkCategory.main_meals: 'Main Meals',
  DrinkCategory.starters: 'Starters',
};

enum DrinkCategory {
  fresh_juice,
  wine,
  whisky,
  others,
  alcoholic,
  non_alcoholic,
  desserts,
  sides,
  main_meals,
  starters
}

enum FoodType { food, drink }

class Drink {
  final String id;
  final String name;
  final DrinkCategory category;
  final double cost;
  final DateTime time;
  final int stock;

  Drink({this.id, this.name, this.category, this.cost, this.time, this.stock});

  Drink.fromJson(String id, Map<String, Object> json)
      : this(
            id: id,
            name: json['name'] as String,
            category: DrinkCategory.values[(json['category'])],
            cost: json['cost'],
            time: DateTime.fromMillisecondsSinceEpoch(json['time']),
            stock: json['stock']);

  Map<String, Object> toJson() {
    return {
      //'id': id,
      'name': name,
      'category': category.index,
      'cost': cost,
      'time': time.millisecondsSinceEpoch,
      'stock': stock
    };
  }

  Drink copyWith({id, name, category, cost, time, stock}) {
    return Drink(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        cost: cost ?? this.cost,
        stock: stock ?? this.stock,
        time: time ?? this.time);
  }
}
