class Order {
  final String id;
  final String waiter;
  final Map<String, int> foodItems; // food name + quantity
  final double total;
  final DateTime at;

  Order({this.id, this.waiter, this.foodItems, this.total, this.at});
}
