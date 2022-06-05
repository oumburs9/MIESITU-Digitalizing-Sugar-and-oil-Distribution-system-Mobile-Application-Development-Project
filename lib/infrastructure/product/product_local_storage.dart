import 'package:miesitu/domain/product/entity/product_model.dart';
import 'package:miesitu/gloabl/local_database_provider.dart';
import 'package:miesitu/infrastracture/local_storage_database.dart';

class LocalProductStorage {
  // late Database _database;
  final provider = DBProvider.dbProvider;

  Future<int> createProduct(Product product) async {
    final db = await provider.database;
    var res = db.insert(prodTable, product.toJson());
    return res;
  }

  Future<int> updateProd(Product product) async {
    final prodDB = await provider.database;

    var res = await prodDB.update(prodTable, product.toJson(),
        where: "id = ?", whereArgs: [product.id]);

    return res;
  }

  Future<int> deleteProduct(int id) async {
    final db = await provider.database;
    var result = await db.delete(prodTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future<List<Product>> fetchProducts() async {
    final db = await provider.database;

    final result = await db.query(productTable);
    List<Product> products = result.isNotEmpty
        ? result.map((item) => Product.fromJson(item)).toList()
        : [];
    return products;
  }
}
