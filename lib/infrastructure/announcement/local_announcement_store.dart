import 'package:miesitu/domain/product/entity/product_model.dart';
import 'package:miesitu/gloabl/local_database_provider.dart';
import 'package:miesitu/infra/local_storage_database.dart';
import 'package:miesitu/domain/announcement/announcement_model.dart';

class LocalProductStorage {
  // late Database _database;

  final provider = DBProvider.dbProvider;
  Future<int> createAnnouncement(Announcement announcement) async {
    final db = await provider.database;
    var res = db.insert(announceTable, announcement.toJson());
    return res;
  }

  Future<int> updateAnnnouncement(Announcement announcement) async {
    final db = await provider.database;
    var res = await db.update(announceTable, announcement.toJson(),
        where: "id = ?", whereArgs: [announcement.id]);

    return res;
  }

  Future<int> deleteAnnouncement(int id) async {
    final db = await provider.database;
    var result =
        await db.delete(announceTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future<List<Announcement>> fetchAnnouncement() async {
    final db = await provider.database;
    final result = await db.query(announceTable);
    List<Announcement> announcements = result.isNotEmpty
        ? result.map((item) => Announcement.fromJson(item)).toList()
        : [];
    return announcements;
  }
}
