import 'dart:math';

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
            total: double.tryParse(json['total'].toString()) ?? json['total'],
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

  static Map<String, Order> concatenateOrders(List<Order> orders) {
    Map<String, Order> concatenatedOrders = {};

    for (Order order in orders) {
      if (concatenatedOrders.keys.contains(order.waiterId)) {
        final t = concatenatedOrders[order.waiterId].total;
        final a = concatenatedOrders[order.waiterId].at;
        final s = concatenatedOrders[order.waiterId].served;
        final p = concatenatedOrders[order.waiterId].paid;
        concatenatedOrders[order.waiterId] = concatenatedOrders[order.waiterId]
            .copyWith(
                total: t + order.total,
                at: DateTime.fromMillisecondsSinceEpoch(max(
                    a.millisecondsSinceEpoch, order.at.millisecondsSinceEpoch)),
                served: s && order.served,
                paid: p && order.paid);

        order.foodItems.forEach((key, value) {
          if (concatenatedOrders[order.waiterId].foodItems.keys.contains(key)) {
            concatenatedOrders[order.waiterId].foodItems[key] += value;
          } else {
            concatenatedOrders[order.waiterId].foodItems.addAll({key: value});
          }
        });

        order.drinkItems.forEach((key, value) {
          if (concatenatedOrders[order.waiterId].drinkItems.containsKey(key)) {
            concatenatedOrders[order.waiterId].drinkItems[key] += value;
          } else {
            concatenatedOrders[order.waiterId].drinkItems.addAll({key: value});
          }
        });
      } else {
        concatenatedOrders[order.waiterId] = order;
      }
    }
    return concatenatedOrders;
  }
}
