/*

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'full_name': fullName, // John Doe
        'company': company, // Stokes and Sons
        'age': age // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }


    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}


Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();



  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
  }
}


FirebaseFirestore.instance
    .collection('users')       // Query, then .get() => QuerySnapshot
.get()
    .then((QuerySnapshot querySnapshot) {
querySnapshot.docs.forEach((doc) {
print(doc["first_name"]);
});
});


FirebaseFirestore.instance
    .collection('users')
.doc(userId)
.get()
    .then((DocumentSnapshot documentSnapshot) {
if (documentSnapshot.exists) {
print('Document exists on the database');
}
});

FirebaseFirestore.instance
    .collection('users')
.where('language', arrayContainsAny: ['en', 'it'])
.get()
    .then(...);


FirebaseFirestore.instance
    .collection('users')
.orderBy('age')
.limitToLast(2)
.get()
    .then(...);

FirebaseFirestore.instance
    .collection('users')
.orderBy('age')
.orderBy('company')
.startAt([4, 'Alphabet Inc.'])
.endAt([21, 'Google LLC'])
.get()
    .then(...);








class Movie {
  Movie({required this.title, required this.genre});

  Movie.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    genre: json['genre']! as String,
  );

  final String title;
  final String genre;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'genre': genre,
    };
  }
}

final moviesRef = FirebaseFirestore.instance.collection('movies').withConverter<Movie>(
  fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
  toFirestore: (movie, _) => movie.toJson(),
);

Future<void> main() async {
  // Obtain science-fiction movies
  List<QueryDocumentSnapshot<Movie>> movies = await moviesRef
      .where('genre', isEqualTo: 'Sci-fi')
      .get()
      .then((snapshot) => snapshot.docs);

  // Get a movie with the id 42
  Movie movie42 = await moviesRef.doc('42').get().then((snapshot) => snapshot.data()!);
}


CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> updateUser() {
  return users
      .doc('ABC123')
      .update({'company': 'Stokes and Sons'})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}


class FoodItemFirestore{
  final CollectionReference foodItems = firestore.collections('foodItems');
  final foodsRef = FirebaseFirestore.instance.collection('foodItems').withConverter<FoodItem>(
    fromFirestore: (snapshot, _) => FoodItem.fromJson(snapshot.data()!),
    toFirestore: (foodItem, _) => foodItem.toJson(),
  );

  void createFoodItem(FoodItem foodItem) async{
    foodItems.add(foodItem.toJson());


    await foodsRef.add(
      foodItem.toJson()
    );

  }

  Future<List<FoodItem>> getFoods() async{

    List<QueryDocumentSnapshot<FoodItem>> foods = await foodsRef
        .where('type', isEqualTo: '0')
        .get()
        .then((snapshot) => snapshot.docs);

  }

  Future<FoodItem> getFoodItem(foodItemId) async{
    FoodItem foodItem = await foodsRef.doc(foodItemId).get().then((snapshot) => snapshot.data());

    return foodItem;
  }
}*/
