import 'package:flutter/material.dart';
import 'package:imagine_bar/screens/create_drink.dart';
import 'package:imagine_bar/screens/create_listing.dart';

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
            child: Text(
              'Imagine Bar',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white),
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
            title: Text('Summary'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => null /*Summary()*/));
            },
          ),
          ListTile(
            title: Text('Add Sale/Refill record'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => null /*Add()*/));
            },
          ),
          ListTile(
            title: Text('Create / Add item to inventory'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => CreateListing()));
            },
          ),
        ],
      ),
    );
  }
}
