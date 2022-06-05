import 'package:equatable/equatable.dart';
import 'package:miesitu/domain/announcement/entity/announcement_model.dart';

abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();
}

class AnnouncementAdminLoad extends AnnouncementEvent {
  const AnnouncementAdminLoad();

  @override
  List<Object> get props => [];
}

class AnnouncementAdminCreate extends AnnouncementEvent {
  final Announcement announcement;

  const AnnouncementAdminCreate(this.announcement);

  @override
  List<Object> get props => [announcement];

  @override
  String toString() => 'Announcement Created {User: $announcement}';
}

class AnnouncementAdminUpdate extends AnnouncementEvent {
  final Announcement announcement;
  // final String name;

  const AnnouncementAdminUpdate(
    // this.name,
     this.announcement);

  @override
  List<Object> get props => [
    // name,
     announcement];

  @override
  String toString() => 'Announcement Updated {User: $announcement}';
}

class AnnouncementAdminDelete extends AnnouncementEvent {
  final String id;

  const AnnouncementAdminDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Announcement Deleted {User Id: $id}';
}
