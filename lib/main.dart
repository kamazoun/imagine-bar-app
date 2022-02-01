import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/foodController.dart';
import 'package:imagine_bar/screens/item_listing.dart';

import 'controllers/auth.dart';
import 'firebase_options.dart';

// TODO: for food, add portion to each plate (for instance for fish or chicken if the boss buys 100 portions we know that it is for 100 services) so for instance a plate 'jollof' would require 1 portion of rice + 1 portion of fish / chicken + 1 tomato + ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthController());
  Get.put(FoodController());

  runApp(MyApp());
}

// TODO: Add a summary for the day. To display how much of each product had been sold that day and the total amount of sales realised.

// TODO: Potential problems: int for units could pose problem for units like liters of liquid or bags of items??? Same for quantity sold.

// TODO: Create waiter profiles, add each order to its waiter. Should be two interfaces one side for waiter to make an order (which will automatically appear on management side) and the system will add up the sales of each waiter automatically at the end of the day.

// TODO: Create waiter side (no cook side), allow to login, (make waiter profile in admin then give them the password or use qr to scan each person). Then waiter

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Imagine Bar Inventory Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ItemListing());
  }
}
