/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/listing_controller.dart';
import 'package:imagine_bar/screens/add.dart';
import 'package:imagine_bar/screens/create_listing.dart';
import 'package:imagine_bar/models/listing.dart';
import 'package:imagine_bar/screens/widgets/main_drawer.dart';

class InventoryListing extends StatelessWidget {
  const InventoryListing({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListingController listingController = Get.find<ListingController>();

    */
/*GetX<ListingController>(
      builder: (controller) {
        print("count 1 rebuild");
        return Text('${listingController.selectedItem.value}');
      },
    ),
*/ /*

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Selected Date: ${listingController.selectedDate?.month ?? '-'}/${listingController.selectedDate?.day ?? '-'}th'),
                  OutlinedButton(
                      onPressed: () async {
                        final r = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime.now(),
                        );

                        listingController.setSelectedDate(r);
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
                  rows: buildDataRows(context, listingController),
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

  List<DataRow> buildDataRows(context, ListingController listingModel) {
    List<Listing> listings = listingModel.items;
    final List<DataRow> r = [];
    for (var listing in listings) {
      if (null != listingModel.selectedDate &&
          listing.time.month == listingModel.selectedDate.month &&
          listing.time.day == listingModel.selectedDate.day) {
        r.add(DataRow(cells: [
          DataCell(Text(listing.foodName)),
          DataCell(Text(listing.openingStock.toString())),
          DataCell(Text(listing.addedStock.toString()), showEditIcon: true,
              onTap: () {
            listingModel.selectedItem = listing.foodName;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Add()));
          }),
          DataCell(Text('${listing.addedStock + listing.openingStock}')),
          DataCell(Text(listing.quantitySold?.toString() ?? '-'),
              showEditIcon: true, onTap: () {
            listingModel.selectedItem = listing.foodName;
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
*/
