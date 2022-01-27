import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imagine_bar/screens/inventory_listing.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'controller/listing_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ListingController(),
      child: MyApp(),
    ),
  );
}

// TODO: Add a summary for the day. To display how much of each product had been sold that day and the total amount of sales realised.

// TODO: Potential problems: int for units could pose problem for units like liters of liquid or bags of items??? Same for quantity sold.

// TODO: Create waiter profiles, add each order to its waiter. Should be two interfaces one side for waiter to make an order (which will automatically appear on management side) and the system will add up the sales of each waiter automatically at the end of the day.

// TODO: Create waiter side (no cook side), allow to login, (make waiter profile in admin then give them the password or use qr to scan each person). Then waiter

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Imagine Bar Inventory Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InventoryListing());
  }
}
