class Listing {
  final String id;
  final String name;
  DateTime time;
  final int openingStock;
  int addedStock;
  final double itemPrice;
  int quantitySold;
  //final int closingStock;

  Listing({
    this.id,
    this.name,
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
        name: name ?? this.name,
        time: time ?? this.time,
        openingStock: openingStock ?? this.openingStock,
        addedStock: addedStock ?? this.addedStock,
        itemPrice: itemPrice ?? this.itemPrice,
        quantitySold: quantitySold ?? this.quantitySold);
  }
}
