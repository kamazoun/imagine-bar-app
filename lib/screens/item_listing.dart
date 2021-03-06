import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/food_controller.dart';
import 'package:imagine_bar/screens/orders.dart';
import 'package:imagine_bar/screens/widgets/drink_listing.dart';
import 'package:imagine_bar/screens/widgets/food_listing.dart';
import 'package:imagine_bar/screens/widgets/main_drawer.dart';

class ItemListing extends StatelessWidget {
  const ItemListing({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          //drawer: MainDrawer(),
          appBar: AppBar(
            title: Text('Imagine Bar'),
            actions: [
              GetBuilder<FoodController>(
                builder: (foodController) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  width: Get.width / 6,
                  height: 25,
                  child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search)),
                    onChanged: (value) {
                      foodController.setSearchedDrinks(value: value);
                    },
                  ),
                ),
              )
            ],
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.no_drinks_outlined)),
                Tab(icon: Icon(Icons.restaurant_menu)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Flex(
                direction: Axis.vertical,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 25),
                        child: Text('Drinks')),
                  ),
                  Flexible(
                    flex: 7,
                    child: DrinkListing(),
                  ),
                ],
              ),
              Flex(
                direction: Axis.vertical,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text('Foods'),
                  ),
                  Flexible(flex: 7, child: FoodListing())
                ],
              ),
            ],
          )),
    );
  }
}
