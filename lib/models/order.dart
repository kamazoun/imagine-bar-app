class Order {
  final String id;
  final String waiterId;
  final String waiterName;
  final Map<String, int> foodItems; // food name + quantity
  final Map<String, int> drinkItems; // drink name + quantity
  final double total;
  final DateTime at;
  final bool served;
  final bool paid;

  Order(
      {this.id,
      this.waiterId,
      this.waiterName,
      this.foodItems,
      this.drinkItems,
      this.total,
      this.at,
      this.served,
      this.paid});

  Order.fromJson(String id, Map<String, Object> json)
      : this(
            id: id,
            waiterId: json['waiterId'] as String,
            waiterName: json['waiterName'] as String,
            total: json['total'],
            at: DateTime.fromMillisecondsSinceEpoch(json['at']),
            foodItems: transform(json['foodItems']),
            drinkItems: transform(json['drinkItems']),
            served: json['served'],
            paid: json['paid']);

  Map<String, Object> toJson() {
    return {
      'waiterId': waiterId,
      'waiterName': waiterName,
      'drinkItems': drinkItems,
      'foodItems': foodItems,
      'total': total,
      'at': at.millisecondsSinceEpoch,
      'served': served,
      'paid': paid,
    };
  }

  Order copyWith(
      {id,
      waiterId,
      waiterName,
      total,
      at,
      foodItems,
      drinkItems,
      served,
      paid}) {
    return Order(
        id: id ?? this.id,
        waiterId: waiterId ?? this.waiterId,
        waiterName: waiterName ?? this.waiterName,
        total: total ?? this.total,
        at: at ?? this.at,
        foodItems: foodItems ?? this.foodItems,
        drinkItems: drinkItems ?? this.drinkItems,
        served: served ?? this.served,
        paid: paid ?? this.paid);
  }

  static Map<String, int> transform(Map<String, dynamic> entry) {
    final Map<String, int> r = {};
    entry.forEach((key, value) {
      r[key] = value;
    });
    return r;
  }
}
