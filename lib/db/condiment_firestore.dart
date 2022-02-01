import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/models/condiment.dart';

class CondimentFirestore {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _condimentsRef =
      _firestore.collection('condiments').withConverter<Condiment>(
            fromFirestore: (snapshot, _) =>
                Condiment.fromJson(snapshot.id, snapshot.data()),
            toFirestore: (condiment, _) => condiment.toJson(),
          );

  static _catchError(error) =>
      Get.snackbar('An Error Occurred', 'Please try again later!');

  static Future createCondiment(Condiment condiment) async {
    return await _condimentsRef.add(condiment);
  }

  static Future<List<Condiment>> getAllCondiments() async {
    List<QueryDocumentSnapshot<Object>> condiments = await _condimentsRef
        .orderBy('stock')
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return condiments
        .map((QueryDocumentSnapshot e) => e.data() as Condiment)
        .toList();
  }

  static Future<List<Condiment>> getFinishedCondiments() async {
    List<QueryDocumentSnapshot<Object>> condiments = await _condimentsRef
        .where('stock', isEqualTo: 0)
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return condiments
        .map((QueryDocumentSnapshot e) => Condiment.fromJson(e.id, e.data()))
        .toList();
  }

  static Future<Condiment> getCondiment(String id) async {
    final Condiment condiment =
        await _condimentsRef.doc(id).get().then((snapshot) => snapshot.data());

    return condiment;
  }
}
