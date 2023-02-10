class MainCartModel {
  List<CartItem> cars;

  MainCartModel({
    required this.cars,
  });

  factory MainCartModel.fromJson(List<dynamic> json, List localData) {
    List<CartItem> cars = [];
    for (int i = 0; i < json.length; i++) {
      cars.add(CartItem.fromJson(json[i], localData[i]));
    }

    return MainCartModel(
        // cars: List<CartItem>.from(json.map((e) => CartItem.fromJson(e))),
        cars: cars);
  }
}

class CartItem {
  final String id;
  final String name;
  String quantity;
  final String price;
  double sub;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.sub,
  });

  factory CartItem.fromJson(
          Map<String, dynamic> json, Map<dynamic, dynamic> localData) =>
      CartItem(
        id: json["product_id"],
        name: json["product_name"],
        quantity: localData["quantity"],
        price: json["w_rate"],
        sub: double.parse(json["w_rate"]) * double.parse(localData["quantity"]),
      );

  setQty(String qty, String price) {
    quantity = qty;
    sub = double.parse(price) * double.parse(qty);
  }
}

// class CartModel {
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   double get totalPrice {
//     double total = 0;
//     for (var item in _items) {
//       total += item.price * item.quantity;
//     }
//     return total;
//   }

  // void addItem(CartItem item) {
  //   _items.add(item);
  // }

  // void removeItem(CartItem item) {
  //   _items.remove(item);
  // }

  // void updateQuantity(CartItem item, int newQuantity) {
  //   final index = _items.indexOf(item);
  //   _items[index] = CartItem(
  //     id: item.id,
  //     name: item.name,
  //     quantity: newQuantity,
  //     price: item.price,
  //   );
  // }
// }
