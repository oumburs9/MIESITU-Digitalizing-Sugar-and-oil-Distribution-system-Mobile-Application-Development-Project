import 'dart:convert';

List<Announcement> announcementFromJson(String str) => List<Announcement>.from(
    json.decode(str).map((x) => Announcement.fromJson(x)));

String announcementToJson(List<Announcement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Announcement {
  Announcement({
    required this.description,
    required this.subject,
    required this.id,
  });
  String description;
  String subject;
  String id;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        description: json["description"],
        subject: json["subject"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "subject": subject,
        "id": id,
      };
}




























// class Announcement{
//   final String? id;
//   final String subject;
//   final String? description;

//   Announcement({required this.id, required this.subject, required this.description});

//   factory Announcement.fromJson(Map<String, dynamic> json) {
//     return Announcement(
//         id: json['_id'],
//         subject: json['subject'],
//         description: (json['description']?.length ?? 0) == 0
//             ? "none"
//             : (json['description']?[0] is Map
//                     ? (json['description']?[0]?['subject'])
//                     : json['description']?[0]) ??
//                 "none");
//   }
// }
