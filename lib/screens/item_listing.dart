import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/foodController.dart';
import 'package:imagine_bar/screens/create_listing.dart';
import 'package:imagine_bar/screens/widgets/drink_listing.dart';
import 'package:imagine_bar/screens/widgets/food_listing.dart';
import 'package:imagine_bar/screens/widgets/main_drawer.dart';

class ItemListing extends StatelessWidget {
  const ItemListing({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FoodController foodController = Get.find<FoodController>();

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Imagine Bar'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateListing()));
              }),
          IconButton(icon: Icon(Icons.upload_file), onPressed: () {}),
        ],
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
                child: Text('Drinks')),
          ),
          Flexible(
            flex: 7,
            child: DrinkListing(),
          ),
          const Divider(),
          Flexible(
            flex: 1,
            child: Text('Foods'),
          ),
          Flexible(flex: 7, child: FoodListing())
        ],
      ),
    );
  }
}
