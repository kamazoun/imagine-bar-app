import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/listing.dart';
import '../controller/listing_controller.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ListingController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Summary'),
        centerTitle: true,
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
                      'Showing summary for: ${controller.selectedDate?.month ?? '-'}/${controller.selectedDate?.day ?? '-'}th'),
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
                      child: Text('Change date'))
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
                  sortColumnIndex: 1,
                  sortAscending: false,
                  headingTextStyle: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blueGrey),
                  columns: [
                    DataColumn(label: Text('Item')),
                    DataColumn(
                        label: Text('Quantity Sold',
                            overflow: TextOverflow.ellipsis)),
                    DataColumn(
                        label: Text('Price', overflow: TextOverflow.ellipsis)),
                    DataColumn(
                        label: Text('Total', overflow: TextOverflow.ellipsis)),
                  ],
                  rows: buildDataRows(context, controller),
                ),
              ),
            ),
          ),
          Flexible(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontSize: 25),
              ),
              Text('¢${calculateTotal(controller)}',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25))
            ],
          ))
        ],
      ),
    );
  }

  double calculateTotal(ListingController listingModel) {
    double total = 0.0;

    for (var listing in listingModel.items) {
      if (null != listingModel.selectedDate &&
          listing.time.month == listingModel.selectedDate.month &&
          listing.time.day == listingModel.selectedDate.day) {
        total += listing.totalPrice;
      }
    }
    return total;
  }

  List<DataRow> buildDataRows(context, ListingController listingModel) {
    List<Listing> listings = listingModel.items;
    final List<DataRow> r = [];
    for (var listing in listings) {
      if (null != listingModel.selectedDate &&
          listing.time.month == listingModel.selectedDate.month &&
          listing.time.day == listingModel.selectedDate.day) {
        r.add(DataRow(cells: [
          DataCell(Text(listing.name)),
          DataCell(Text(listing.quantitySold?.toString() ?? '-')),
          DataCell(Text('¢${listing.itemPrice}')),
          DataCell(Text('¢${listing.totalPrice}')),
        ]));
      }
    }
    return r;
  }
}
