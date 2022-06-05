import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:labpract/domain/announcement/entity/announcement_model.dart';

class AnnouncementDataProvider {
  final announcementUrl = 'http://127.0.0.1:7000/api/announcements/';

  Future<Announcement> createAnnounce(Announcement announcement) async {
    final response = await http.post(
      Uri.parse(announcementUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'subject': announcement.subject,
        'description': announcement.description,
      }),
    );
    if (response.statusCode == 201) {
      print("Successful creation of a announcement");
      return Announcement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Announcement');
    }
  }

  Future<List<Announcement>> fetchAllAnnouncement() async {
    final response = await http.get(Uri.parse('$announcementUrl/'));

    if (response.statusCode == 200) {
      print("Successfully fetched announcement: ${response.body}");
      final announcements = jsonDecode(response.body) as List;
      return announcements
          .map((announcement) => Announcement.fromJson(announcement))
          .toList();
      // return Announcement.fromJson(jsonDecode(response.body));
      //  (response.body as List)
      //     .map((u) => Announcement.fromJson(u))
      //     .toList();
    } else {
      throw Exception('Failed to load announcement');
    }
  }

  Future<Announcement> updateAnnounce(
      String id, Announcement announcement) async {
    final http.Response response = await http.put(
      Uri.parse('$announcementUrl/${announcement.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'id': announcement.id,
        'subject': announcement.subject,
        'description': announcement.description,
      }),
    );

    if (response.statusCode == 200) {
      print("Successful updation of a Announcement");
      return Announcement.fromJson(jsonDecode(response.body));
    }
    print("Unsuccessful updation of a Announcement");
    return Announcement(id: "", subject: "", description: "");
  }

  Future<http.Response> deleteAnnounce(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$announcementUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
    // if (response.statusCode != 204) {
    //   // print(response.body);
    //   throw Exception('Failed to delete Announcement!.');
    // }
  }
}
