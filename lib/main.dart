import 'package:flutter/material.dart';
import 'package:imagine_bar/add.dart';
import 'package:imagine_bar/create.dart';
import 'package:imagine_bar/summary.dart';
import 'package:provider/provider.dart';

import 'listing.dart';
import 'listingmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ListingModel(),
      child: MyApp(),
    ),
  );
}

// TODO: Add a summary for the day. To display how much of each product had been sold that day and the total amount of sales realised.

// TODO: Potential problems: int for units could pose problem for units like liters of liquid or bags of items??? Same for quantity sold.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Imagine Bar Inventory Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Listin());
  }
}

class BNBPV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: null,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.addchart), label: 'Summary')
        ],
      ),
    );
  }
}

class Listin extends StatelessWidget {
  const Listin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ListingModel>(context, listen: true);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'Imagine Bar',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 28),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Summary'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Summary()));
              },
            ),
            ListTile(
              title: Text('Add Sale/Refill record'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Add()));
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
      ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Selected Date: ${controller.selectedDate?.month ?? '-'}/${controller.selectedDate?.day ?? '-'}th'),
                  OutlinedButton(
                      onPressed: () async {
                        final r = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime.now(),
                        );

                        controller.setSelectedDate(r);
                      },
                      child: Text('Select new date'))
                ],
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blueGrey),
                  columns: [
                    DataColumn(label: Text('Item')),
                    DataColumn(
                        label: Text('Opening Stock',
                            overflow: TextOverflow.ellipsis)), // Stock
                    DataColumn(
                        label: Text('Added Stock',
                            overflow: TextOverflow.ellipsis)),
                    DataColumn(
                        label: Text('Total Stock',
                            overflow: TextOverflow.ellipsis)),
                    DataColumn(
                        label:
                            Text('Quantity', overflow: TextOverflow.ellipsis)),
                    DataColumn(
                        label: Text('Price', overflow: TextOverflow.ellipsis)),
                    DataColumn(
                        label: Text('Total', overflow: TextOverflow.ellipsis)),
                    DataColumn(
                        label: Text('Closing Stock',
                            overflow: TextOverflow.ellipsis)),
                  ],
                  rows: buildDataRows(context, controller, controller),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Add()),
                  );
                },
                child: Text('Add Entry')),
          )
        ],
      ),
    );
  }

  // listingModel and controller are actually the SAME
  List<DataRow> buildDataRows(context, ListingModel listingModel, controller) {
    List<Listing> listings = listingModel.items;
    final List<DataRow> r = [];
    for (var listing in listings) {
      if (null != controller.selectedDate &&
          listing.time.month == controller.selectedDate.month &&
          listing.time.day == controller.selectedDate.day) {
        r.add(DataRow(cells: [
          DataCell(Text(listing.name)),
          DataCell(Text(listing.openingStock.toString())),
          DataCell(Text(listing.addedStock.toString()), showEditIcon: true,
              onTap: () {
            listingModel.selectedItem = listing.name;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Add()));
          }),
          DataCell(Text('${listing.addedStock + listing.openingStock}')),
          DataCell(Text(listing.quantitySold?.toString() ?? '-'),
              showEditIcon: true, onTap: () {
            listingModel.selectedItem = listing.name;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Add()));
          }),
          DataCell(Text('¢${listing.itemPrice}')),
          DataCell(Text('¢${listing.totalPrice}')),
          DataCell(Text('${listing.closingStock}')),
        ]));
      }
    }
    return r;
  }
}
