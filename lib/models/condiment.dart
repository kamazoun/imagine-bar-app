class Condiment {
  final String id;
  final String name;
  final double cost;
  final int stock;
  final String unit;

  Condiment({this.id, this.name, this.cost, this.stock, this.unit});

  Condiment.fromJson(String id, Map<String, Object> json)
      : this(
            id: id,
            name: json['name'] as String,
            cost: json['cost'],
            stock: json['stock'],
            unit: json['unit']);

  Map<String, Object> toJson() {
    return {
      //'id': id,
      'name': name,
      'cost': cost,
      'stock': stock,
      'unit': unit,
    };
  }

  Condiment copyWith({id, name, cost, time, stock}) {
    return Condiment(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      stock: stock ?? this.stock,
      unit: unit ?? this.unit,
    );
  }
}
