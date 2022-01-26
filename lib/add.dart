import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'listingmodel.dart';

class Add extends StatelessWidget {
  final TextEditingController addedController = TextEditingController();

  final TextEditingController soldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listingsModel = Provider.of<ListingModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a Sale/Refill record'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () => add(context, listingsModel))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: MediaQuery.of(context).size.width / 7),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PopupMenuButton(
                child: SelectedItemText(),
                itemBuilder: (context) {
                  return buildPopUpMenu(listingsModel.items);
                },
                onSelected: (val) {
                  listingsModel.setSelectedItem(val);
                },
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: soldController,
                decoration: InputDecoration(
                    labelText: 'Please Enter the number of items sold'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: addedController,
                decoration: InputDecoration(
                    labelText: 'Enter the number of items added to the stock'),
              ),
              const Divider(
                indent: 25.0,
                endIndent: 25.0,
              ),
              OutlinedButton(
                  onPressed: () => add(context, listingsModel),
                  child: Text('Ok'))
            ],
          ),
        ),
      ),
    );
  }

  add(context, listingsModel) {
    if (soldController.text.isEmpty ||
        addedController.text.isEmpty ||
        null == listingsModel.selectedItem) {
      return;
    }

    listingsModel.add(
      int.parse(addedController.text.trim()),
      int.parse(soldController.text.trim()),
    );

    Navigator.pop(context);
  }

  List<PopupMenuItem> buildPopUpMenu(listings) {
    final List<PopupMenuItem> r = [];
    final List<String> isIn = [];
    for (var item in listings) {
      final name = item.name;
      if (isIn.contains(name)) {
        continue;
      }
      r.add(
        PopupMenuItem(
          child: Text(name),
          value: name,
        ),
      );
      isIn.add(name);
    }
    return r;
  }
}

class SelectedItemText extends StatelessWidget {
  const SelectedItemText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListingModel>(
      builder: (context, listing, child) {
        return Text(
          listing.selectedItem ?? 'Please Select the item to record',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              shadows: [
                Shadow(
                    color: Colors.grey, blurRadius: 5, offset: Offset(-2, -1))
              ],
              decoration: TextDecoration.underline),
        );
      },
    );
  }
}
