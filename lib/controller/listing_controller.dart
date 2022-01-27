import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:imagine_bar/contants.dart';
import 'package:imagine_bar/models/listing.dart';

class ListingController extends ChangeNotifier {
  List<Listing> _listings = DummyData
      .dummyListings; // TODO: Do not manually create this. Each day, compute the daily listings from the previous day ones. Then save it.

  String selectedItem;
  DateTime selectedDate = DateTime.now();

  void setSelectedItem(val) {
    selectedItem = val;
    notifyListeners();
  }

  void setSelectedDate(val) {
    selectedDate = val;
    notifyListeners();
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
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void add(int added, int sold) {
    final old = items.singleWhere((i) =>
        i.name == selectedItem &&
        i.time.day == DateTime.now().day &&
        i.time.month == DateTime.now().month);

    old.addedStock += added;
    old.quantitySold += sold;

    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _listings.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  int nextId() {
    return int.parse(_listings.last.id) + 1;
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

    notifyListeners();
  }

  void fuse() {
    List<String> names = [];
    for (var listing in _listings) {
      if (names.contains(listing.name)) {
        //_listings.where((l) => l.name == listing.name).first.
      }
    }
  }
}
