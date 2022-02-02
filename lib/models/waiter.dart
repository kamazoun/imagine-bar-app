class Waiter {
  final String id;
  final String name;
  final DateTime since;
  final bool gender; // false = female

  Waiter({this.id, this.name, this.since, this.gender});

  Waiter.fromJson(String id, Map<String, Object> json)
      : this(
          id: id,
          name: json['name'] as String,
          since: DateTime.fromMillisecondsSinceEpoch(json['since']),
          gender: json['gender'],
        );

  Map<String, Object> toJson() {
    return {
      'name': name,
      'since': since.millisecondsSinceEpoch,
      'gender': gender,
    };
  }

  Waiter copyWith({id, name, since, gender}) {
    return Waiter(
        id: id ?? this.id,
        name: name ?? this.name,
        since: since ?? this.since,
        gender: gender ?? this.gender);
  }
}
