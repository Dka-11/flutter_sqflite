class Item {
  late int _id;
  late String name;
  late int price;

  int get id => _id;

  // Konstruktor Versi 1
  Item({required this.name, required this.price});

  // Konstruktor Versi 2 : Konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    // This Map in the form of String and dynamic.
    // Retrieve data from SQL that stored in the form of Map
    // After which it will be stored again in the form of variables
    _id = map['id'];
    //data from id which in the form of map stored in the form of variables "_id"
    // Map id --> variable _id
    name = map['name'];
    price = map['price'];
  }

// Convert from Item to Map
// Do Update & Insert
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      // "_id" is item convert to map "id"
      'name': name,
      'price': price,
    };
  }
}
