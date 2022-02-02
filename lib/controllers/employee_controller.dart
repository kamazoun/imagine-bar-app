import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/db/waiter_firestore.dart';
import 'package:imagine_bar/models/waiter.dart';

class EmployeeController extends GetxController {
  RxList<Waiter> _waiters = RxList<Waiter>([]);

  List<Waiter> get waiters => _waiters;

  EmployeeController() {
    _setAllWaiters();
  }

  _setAllWaiters() async {
    final d = await WaiterFirestore.getAllWaiters();
    _waiters.assignAll(d);
  }

  createWaiter(Waiter waiter) async {
    final DocumentReference r = await WaiterFirestore.createWaiter(waiter);
    _waiters.add(waiter.copyWith(id: r.id));

    update(); // Surprisingly without that, after adding GetX does not automatically refresh.
  }
}
