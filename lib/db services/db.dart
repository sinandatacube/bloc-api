import 'dart:developer';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:simple_bloc_api/db%20services/table.dart';

part 'db.g.dart';

@DriftDatabase(tables: [Bags])
class AppDB extends _$AppDB {
  AppDB() : super(_openConnection());
  @override
  int get schemaVersion => 3;

  Future<List<Bag>> getItems() async {
    log("reading db data");
    return await select(bags).get();
  }

  // Future deleteAll() async {
  //   log("reading db data");
  //   return await delete(items).go();
  // }

  addItems(BagsCompanion itemsCompanion) async {
    log("adding item to db");
    return await into(bags).insert(itemsCompanion);
  }

  // setChecked(int itemId) async {
  //   log("check item from db");
  //   Item item =
  //       await (select(items)..where((t) => t.id.equals(itemId))).getSingle();
  //   bool check = !item.checked;
  //   (update(items)..where((t) => t.id.equals(itemId)))
  //       .write(ItemsCompanion(checked: Value(check)));
  //   return check;
  // }
  updateItem(String productID, String newQty) async {
    BagsCompanion item =
        BagsCompanion(productId: Value(productID), quantity: Value(newQty));
    log("updating item from db");
    return await (update(bags)..where((tbl) => tbl.productId.equals(productID)))
        .write(item);
  }

  deleteItems(String productId) async {
    log("deleting item from db");
    return (delete(bags)..where((t) => t.productId.equals(productId))).go();
  }

  deleteItemsName(String productId) async {
    log("deleting item from db");
    return (delete(bags)..where((t) => t.productId.equals(productId))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}


//flutter pub run build_runner build --delete-conflicting-outputs
//flutter pub run build_runner build 