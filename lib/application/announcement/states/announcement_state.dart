import 'package:miesitu/domain/announcement/entity/announcement_model.dart';
import 'package:equatable/equatable.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object> get props => [];
}

class AnnouncementAdminLoading extends AnnouncementState {}

class AnnouncementAdminOperationSuccess extends AnnouncementState {
  final Iterable<Announcement> announcement;

  AnnouncementAdminOperationSuccess([this.announcement = const []]);

  @override
  List<Object> get props => [
        announcement,
      ];
}

class AnnouncementAdminOperationFailure extends AnnouncementState {}

// class AnnouncementAdminOperationCreated extends AnnouncementState {}

// class AnnouncementAdminDeleted extends AnnouncementState {}
