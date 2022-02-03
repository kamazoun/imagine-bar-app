import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/db/order_firestore.dart';
import 'package:imagine_bar/models/drink.dart';
import 'package:imagine_bar/models/food.dart';
import 'package:imagine_bar/models/order.dart';

class OrderController extends GetxController {
  RxList<Order> _orders = RxList<Order>([]);

  List<Order> get orders => _orders;

  DateTime orderSummaryDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  OrderController() {
    setAllOrders();
  }

  setAllOrders() async {
    final d = await OrderFirestore.getAllOrders();
    _orders.assignAll(d);
  }

  createOrder(Order order) async {
    final DocumentReference r = await OrderFirestore.createOrder(order);
    _orders.add(order.copyWith(id: r.id));

    update(); // Surprisingly without that, after adding GetX does not automatically refresh.
  }

  Stream<QuerySnapshot<Order>> ordersStream() {
    return OrderFirestore.getAllOrdersStream();
  }

  void setSelectedSummaryDate(DateTime r) {
    orderSummaryDate = r;
    update();
  }

  List<Order> getSelectedDayOrders() {
    final first = orderSummaryDate;
    final second = first.add(Duration(days: 1));
    return orders
        .where((element) =>
            element.at.isAfter(first) && element.at.isBefore(second))
        .toList();
  }

  Map<Drink, int> getEachDrinksSold() {
    List<Order> orders = getSelectedDayOrders();
    final FoodController foodController = Get.find<FoodController>();

    Map<Drink, int> r = {};

    for (Order order in orders) {
      for (var entry in order.drinkItems.entries) {
        final Drink drink = foodController.drinks
            .firstWhereOrNull((element) => element.id == entry.key);
        if (null != drink) {
          r.addAll({drink: entry.value});
        }
      }
    }

    return r;
  }

  Map<Food, int> getEachFoodsSold() {
    List<Order> orders = getSelectedDayOrders();
    final FoodController foodController = Get.find<FoodController>();

    Map<Food, int> r = {};

    for (Order order in orders) {
      for (var entry in order.foodItems.entries) {
        final Food food = foodController.foods
            .firstWhereOrNull((element) => element.id == entry.key);
        if (null != food) {
          r.addAll({food: entry.value});
        }
      }
    }

    return r;
  }

  double getTotalAmountSold() {
    List<Order> orders = getSelectedDayOrders();
    double s = 0.0;
    for (Order order in orders) {
      s += order.total;
    }

    return s;
  }

  List<int> getTotalQuantityOfDrinksFoodsSold() {
    List<Order> orders = getSelectedDayOrders();
    int d = 0;
    int f = 0;
    for (Order order in orders) {
      d += order.drinkItems.length;
      f += order.foodItems.length;
    }

    return [d, f];
  }

  Future<List<Order>> getDateOrders() async {
    List<Order> dateOrder =
        await OrderFirestore.getDateOrders(orderSummaryDate);

    return dateOrder;
  }
}
