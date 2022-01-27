import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imagine_bar/screens/add.dart';
import 'package:imagine_bar/controller/listing_controller.dart';
import 'package:imagine_bar/screens/create.dart';
import 'package:imagine_bar/models/listing.dart';
import 'package:imagine_bar/screens/summary.dart';
import 'package:provider/provider.dart';

class InventoryListing extends StatelessWidget {
  const InventoryListing({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ListingController>(context, listen: true);

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
  List<DataRow> buildDataRows(
      context, ListingController listingModel, controller) {
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
