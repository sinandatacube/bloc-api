import 'dart:developer';
import 'package:simple_bloc_api/db%20services/db.dart';

class CartController {
  // List ids = [];
  // AppDB appDB = AppDB();
  static final AppDB appDB = AppDB();

  getItemsFromTable() async {
    List ids = [];
    List<Bag> items = await appDB.getItems();
    log(items.toString());

    items.forEach((element) {
      Map data = {'id': element.productId, 'quantity': element.quantity};
      ids.add(data);
      // print(ids);
    });
    log(ids.toString());
    return ids;
  }

  insertToTable(BagsCompanion product) async {
    List<Bag> items = await appDB.getItems();
    items.forEach((element) {
      // log(element.productId, name: 'element');
      // log(product.productId.value, name: 'product');
      if (element.productId == product.productId.value) {
        appDB.deleteItems(product.productId.value);
      }
    });
    var result = await appDB.addItems(product);
    log(result.toString());
    getItemsFromTable();
  }

  updateCartItemQty(String productId, String newQty) async {
    List<Bag> items = await appDB.getItems();
    items.forEach((element) {
      if (element.productId == productId) {
        appDB.updateItem(productId, newQty);
      }
    });
    getItemsFromTable();
  }

  deleteFromCart(String productId) {
    print('deleted from db');
    appDB.deleteItemsName(productId);
  }
}



// class AppDB {
//   static final AppDB _instance = AppDB._internal();
//   QueryExecutor? queryExecutor;

//   factory AppDB() {
//     return _instance;
//   }

//   AppDB._internal() {
//     this.queryExecutor = QueryExecutor();
//   }
// }