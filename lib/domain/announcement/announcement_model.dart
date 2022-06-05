import 'dart:convert';

List<Announcement> announcementFromJson(String str) => List<Announcement>.from(
    json.decode(str).map((x) => Announcement.fromJson(x)));

String announcementToJson(List<Announcement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Announcement {
  Announcement({
    required this.id,
    required this.announcementSubject,
    required this.announcementBody,
    this.announcedAt,
    this.updateAnnouncement,
  });

  int id;
  String announcementSubject;
  String announcementBody;
  DateTime? announcedAt;
  DateTime? updateAnnouncement;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json["id"],
        announcementSubject: json["announcement_subject"],
        announcementBody: json["announcement_body"],
        // announcedAt: DateTime.parse(json["announced_at"]),
        // updateAnnouncement: DateTime.parse(json["update_announcement"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "announcement_subject": announcementSubject,
        "announcement_body": announcementBody,
        // "announced_at":
        //     "${announcedAt!.year.toString().padLeft(4, '0')}-${announcedAt!.month.toString().padLeft(2, '0')}-${announcedAt!.day.toString().padLeft(2, '0')}",
        // "update_announcement":
        //     "${updateAnnouncement!.year.toString().padLeft(4, '0')}-${updateAnnouncement!.month.toString().padLeft(2, '0')}-${updateAnnouncement!.day.toString().padLeft(2, '0')}",
      };
}
