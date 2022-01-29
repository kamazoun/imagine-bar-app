class Listing {
  final String id;
  final String
      foodId; // I added it here so that everytime a drink is ordered or replenished in the stock, its listing can be updated
  final String foodName;
  DateTime time;
  final int openingStock; // Opening stock
  int addedStock;
  final double itemPrice;
  int quantitySold;
  //final int closingStock;

  Listing({
    this.id,
    this.foodId,
    this.foodName,
    this.time,
    this.openingStock,
    this.addedStock,
    this.itemPrice,
    this.quantitySold,
  });

  double get totalPrice => (itemPrice ?? 0) * (quantitySold ?? 0);

  int get closingStock =>
      (openingStock ?? 0) + (addedStock ?? 0) - (quantitySold ?? 0);

  Listing copyWith({
    id,
    name,
    time,
    openingStock,
    addedStock,
    itemPrice,
    quantitySold,
  }) {
    return Listing(
        id: id ?? this.id,
        foodName: name ?? this.foodName,
        time: time ?? this.time,
        openingStock: openingStock ?? this.openingStock,
        addedStock: addedStock ?? this.addedStock,
        itemPrice: itemPrice ?? this.itemPrice,
        quantitySold: quantitySold ?? this.quantitySold);
  }
}
