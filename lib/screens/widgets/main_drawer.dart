import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/screens/create_condiment.dart';
import 'package:imagine_bar/screens/create_drink.dart';
import 'package:imagine_bar/screens/create_food.dart';
import 'package:imagine_bar/screens/create_waiter.dart';
import 'package:imagine_bar/screens/edit_drink.dart';
import 'package:imagine_bar/screens/edit_food.dart';
import 'package:imagine_bar/screens/item_listing.dart';
import 'package:imagine_bar/screens/stats.dart';

import '../summary.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Imagine Bar',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Add Drink to Inventory'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => CreateDrink()));
            },
          ),
          ListTile(
            title: Text('Add Condiment to kitchen'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => CreateCondiment()));
            },
          ),
          ListTile(
            title: Text('Add Food to the menu'),
            onTap: () {
              Get.to(() => CreateFood());
            },
          ),
          ListTile(
            title: Text('Add waiter to the team'),
            onTap: () {
              Get.to(() => CreateWaiter());
            },
          ),
          ListTile(
            title: Text('Edit Drink'),
            onTap: () {
              Get.to(() => EditDrink());
            },
          ),
          ListTile(
            title: Text('Edit Food'),
            onTap: () {
              Get.to(() => EditFood());
            },
          ),
          ListTile(
            title: Text('Summary'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => Summary()));
            },
          ),
          ListTile(
            title: Text('Stats'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => Stats()));
            },
          ),
          ListTile(
            title: Text('Refresh all controllers - for offline'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => Stats()));
            },
          ),
        ],
      ),
    );
  }
}
