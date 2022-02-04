import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/employee_controller.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/controllers/order_controller.dart';
import 'package:imagine_bar/screens/item_listing.dart';
import 'package:imagine_bar/screens/orders.dart';

import 'controllers/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthController());
  Get.put(FoodController());
  Get.put(OrderController());
  Get.put(EmployeeController());

  runApp(MyApp());
}

// TODO: Add a summary for the day. To display how much of each product had been sold that day and the total amount of sales realised.

// TODO: Potential problems: int for units could pose problem for units like liters of liquid or bags of items??? Same for quantity sold.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Imagine Bar Inventory Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Orders());
  }
}
