/*
import 'dart:collection';

import 'package:get/get.dart';
import 'package:imagine_bar/constants.dart';
import 'package:imagine_bar/models/listing.dart';

class ListingController extends GetxController {
  RxList<Listing> _listings = RxList<Listing>(
      []); //DummyData.dummyListings; // TODO: Do not manually create this. Each day, compute the daily listings from the previous day ones. Then save it.

  String selectedItem;
  DateTime selectedDate = DateTime.now();

  void setSelectedItem(val) {
    selectedItem = val;
    update();
  }

  void setSelectedDate(val) {
    selectedDate = val;
    update();
  }

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Listing> get items {
    // TODO: BOMBE A EFFACER:
    if (DateTime.now().month > 1) {
      return null;
    }

    if (_listings.last.time.day != DateTime.now().day) {
      startDay();
    }

    return UnmodifiableListView(_listings);
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void create(Listing listing) {
    _listings.add(listing);
  }

  void add(int added, int sold) {
    final old = items.singleWhere((i) =>
        i.foodName == selectedItem &&
        i.time.day == DateTime.now().day &&
        i.time.month == DateTime.now().month);

    old.addedStock += added;
    old.quantitySold += sold;

    update(); // we update because it is the value inside the reactive list that is changed not the list itself
  }

  /// Removes all items from the cart.
  void removeAll() {
    _listings.clear();
    // This call tells the widgets that are listening to this model to rebuild.
  }

  int nextId() {
    return int.parse(_listings.last.id) +
        1; // TODO: Use firebase automatic id assignment
  }

  void startDay() {
    List<Listing> t = [];
    for (var listing in _listings) {
      t.add(listing.copyWith(
          id: nextId().toString(),
          quantitySold: 0,
          addedStock: 0,
          openingStock: listing.closingStock,
          time: DateTime.now()));
    }
    _listings.addAll(t);

    update();
  }
}
*/
