<<<<<<< HEAD
import 'package:labpract/infrastructure/announcement/data_provider/announcement_provider.dart';
import 'package:labpract/domain/announcement/entity/announcement_model.dart';
=======
import 'package:miesitu/domain/announcement/entity/announcement_model.dart';
import 'package:miesitu/infrastructure/announcement/data_provider/announcement_provider.dart';
>>>>>>> f1942a148f6737ce258d15325cd8de66c71659fe

abstract class Re {}

class AnnouncementRepository extends Re {
  final AnnouncementDataProvider dataProvider;
  AnnouncementRepository({required this.dataProvider});

  Future<Announcement> createAnnounce(Announcement announcement) async {
    return dataProvider.createAnnounce(announcement);
  }

  Future<void> updateAnnounce(String id, Announcement announcement) async {
    dataProvider.updateAnnounce(id, announcement);
  }

  Future<List<Announcement>> fetchAllAnnouncement() async {
    return dataProvider.fetchAllAnnouncement();
  }

  Future<void> deleteAnnounce(String id) async {
    dataProvider.deleteAnnounce(id);
  }
}
