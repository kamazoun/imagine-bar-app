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
    return _ordersRef.get().asStream();
  }
}
