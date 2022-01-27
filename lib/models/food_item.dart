enum FoodCategory {
  juice,
}

class FoodItem {
  final String id;
  final String name;
  final FoodCategory category;
  final double cost;
  final DateTime time;

  FoodItem({this.id, this.name, this.category, this.cost, this.time});

  //fromFirebaseDocument // TODO: Maybe no firebase, just local system. Will waiters have network all the time?? Actually I got it wrong, we can have only two computers, one for waiting & the other for managing. If a waiter wants to place an order she clicks on the category then foodItem then she chooses her profile then the order is saved in her name. Yeah, but even for 2 computers, I would need to keep them in sync, read the most recent data => USE FIREBASE
  // TODO: build firebase account for kasper jaspin and link it to mtn phone number

}
