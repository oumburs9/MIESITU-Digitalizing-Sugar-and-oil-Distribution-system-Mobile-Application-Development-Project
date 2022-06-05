import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const productTable = 'productTable';
const announcementTable = 'announcementTable';

class DBProvider {
  static final DBProvider usrProvider = DBProvider();
  late Database _database;

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $productTable ("
        "id TEXT PRIMARY KEY, "
        "product_name TEXT, "
        "product_price TEXT ,"
        "product_description TEXT,"
        ")");
    await database.execute("CREATE TABLE $announcementTable ("
        "id TEXT PRIMARY KEY, "
        "subject TEXT, "
        "description TEXT ,"
        ")");
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory filesDirectory = await getApplicationDocumentsDirectory();
    String path = join(filesDirectory.path, "User.db");

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
    );
    return database;
  }
}
