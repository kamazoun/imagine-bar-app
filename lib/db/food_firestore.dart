import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/food.dart';

class FoodFirestore {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _foodsRef =
      _firestore.collection('foods').withConverter<Food>(
            fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()),
            toFirestore: (food, _) => food.toJson(),
          );

  static _catchError(error) =>
      Get.snackbar('An Error Occurred', 'Please try again later!');

  static Future createFood(Food food) async {
    return await _foodsRef.add(food);
  }

  static Future<List<Food>> getAllFoods() async {
    List<QueryDocumentSnapshot<Object>> foods = await _foodsRef
        .orderBy('stock')
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return foods
        .map((QueryDocumentSnapshot e) => Food.fromJson(e.data()))
        .toList();
  }

  static Future<List<Food>> getEmptyFoodsWithEmptyCondiments(
      List<Condiment> finishedCondiment) async {
    List<QueryDocumentSnapshot<Object>> foods = await _foodsRef
        .where('portions[0]', whereIn: finishedCondiment)
        .get()
        .then((QuerySnapshot<Object> snapshot) => snapshot.docs);

    return foods
        .map((QueryDocumentSnapshot e) => Food.fromJson(e.data()))
        .toList();
  }

  static Future<Food> getFood(String id) async {
    Food food =
        await _foodsRef.doc(id).get().then((snapshot) => snapshot.data());

    return food;
  }
}
