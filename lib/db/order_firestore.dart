import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/models/order.dart';

class OrderFirestore {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _ordersRef =
      _firestore.collection('orders').withConverter<Order>(
            fromFirestore: (snapshot, _) =>
                Order.fromJson(snapshot.id, snapshot.data()),
            toFirestore: (order, _) => order.toJson(),
          );

  static _catchError(error) =>
      Get.snackbar('An Error Occurred', 'Please try again later!');

  static Future createOrder(Order order) async {
    return await _ordersRef.add(order);
  }

  static Future<List<Order>> getAllOrders() async {
    List<QueryDocumentSnapshot<Object>> orders = await _ordersRef
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return orders.map((QueryDocumentSnapshot e) => e.data() as Order).toList();
  }

  static Future<List<Order>> getUnpaidOrders() async {
    List<QueryDocumentSnapshot<Object>> orders = await _ordersRef
        .where('paid', isEqualTo: false)
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return orders
        .map((QueryDocumentSnapshot e) => Order.fromJson(e.id, e.data()))
        .toList();
  }

  static Future<Order> getOrder(String id) async {
    final Order order =
        await _ordersRef.doc(id).get().then((snapshot) => snapshot.data());

    return order;
  }

  static Stream<QuerySnapshot<Order>> getAllOrdersStream() {
    return _ordersRef
        .orderBy('at', descending: true)
        .limit(25)
        .get()
        .asStream();
  }

  static Future<List<Order>> getDateOrders(DateTime orderSummaryDate) async {
    List<QueryDocumentSnapshot<Object>> orders = await _ordersRef
        .where('at',
            isGreaterThan: orderSummaryDate.millisecondsSinceEpoch,
            isLessThan:
                orderSummaryDate.add(Duration(days: 1)).millisecondsSinceEpoch)
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return orders.map((QueryDocumentSnapshot e) => e.data() as Order).toList();
  }

  static Future<List<Order>> getRangeOrders(
      DateTime orderSummaryDate, DateTime orderStatDate) async {
    List<QueryDocumentSnapshot<Object>> orders = await _ordersRef
        .where('at',
            isGreaterThan: orderSummaryDate.millisecondsSinceEpoch,
            isLessThan:
                orderStatDate.add(Duration(days: 1)).millisecondsSinceEpoch)
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return orders.map((QueryDocumentSnapshot e) => e.data() as Order).toList();
  }

  static Future updateOrder(Order order) async {
    await _ordersRef.doc(order.id).update(order.toJson());
  }

  static Future cancelOrder(Order order) async {
    await _ordersRef.doc(order.id).delete();
  }

  static Future payOrders(Order order) async {
    await _ordersRef.doc(order.id).update({'paid': true});
  }
}
