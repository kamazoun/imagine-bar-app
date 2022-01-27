import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/listing.dart';
import '../controller/listing_controller.dart';

class CreateListing extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listingsModel =
        Provider.of<ListingController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Item to Inventory'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () => createItem(context, listingsModel))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5, horizontal: MediaQuery.of(context).size.width / 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Please enter the name of new item'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: stockController,
                decoration: InputDecoration(
                    labelText: 'Enter the initial number of item in the stock'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: priceController,
                decoration: InputDecoration(
                    labelText: 'Enter the price of the item',
                    prefixIcon: Icon(Icons.money)),
              ),
              const Divider(
                indent: 25.0,
                endIndent: 25.0,
              ),
              OutlinedButton(
                  onPressed: () => createItem(context, listingsModel),
                  child: Text('Ok'))
            ],
          ),
        ),
      ),
    );
  }

  createItem(context, ListingController listingsModel) {
    if (nameController.text.isEmpty ||
        stockController.text.isEmpty ||
        priceController.text.isEmpty) {
      return;
    }

    for (var listing in listingsModel.items) {
      if (listing.name == nameController.text.trim()) {
        return;
      }
    }

    final newItem = Listing(
        itemPrice: double.parse(priceController.text),
        id: '${int.parse(listingsModel.items.last.id) + 1}',
        openingStock: 0,
        addedStock: int.parse(stockController.text.trim()),
        quantitySold: 0,
        time: DateTime.now(),
        name: nameController.text.trim());
    listingsModel.create(newItem);

    Navigator.pop(context);
  }
}
