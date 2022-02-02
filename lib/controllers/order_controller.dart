import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/db/order_firestore.dart';
import 'package:imagine_bar/models/order.dart';

class OrderController extends GetxController {
  RxList<Order> _orders = RxList<Order>([]);

  List<Order> get orders => _orders;

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
}
