// ignore_for_file: avoid_print

import 'package:miesitu/application/announcement/events/announcement_event.dart';
import 'package:miesitu/application/announcement/states/announcement_state.dart';
import '/infrastructure/announcement/repository/announcement_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository announcementRepository;

  AnnouncementBloc({required this.announcementRepository})
      : super(AnnouncementAdminLoading()) {
    on<AnnouncementAdminLoad>((event, emit) async {
      emit(AnnouncementAdminLoading());
      try {
        final announcementAdmins =
            await announcementRepository.fetchAllAnnouncement();
        print("Successfully listed");
        emit(AnnouncementAdminOperationSuccess(
          announcementAdmins,
        ));
      } catch (_) {
        emit(AnnouncementAdminOperationFailure());
      }
    });

    on<AnnouncementAdminCreate>((event, emit) async {
      // emit(AnnouncementAdminLoading());
      try {
        print("create announcement ");
        await announcementRepository.createAnnounce(event.announcement);
        print("Successfully listed");
        emit(AnnouncementAdminOperationSuccess());
      } catch (_) {
        print("create failed");
        emit(AnnouncementAdminOperationFailure());
      }
    });
    on<AnnouncementAdminUpdate>((event, emit) async {
      try {
        await announcementRepository.updateAnnounce(
          event.announcement.id,
          event.announcement,
        );
        final announcementAdmins =
            await announcementRepository.fetchAllAnnouncement();
        print("Successfully updated and listed");
        emit(AnnouncementAdminOperationSuccess(
          announcementAdmins,
        ));
      } catch (_) {
        emit(AnnouncementAdminOperationFailure());
        rethrow;
      }
    });
    on<AnnouncementAdminDelete>((event, emit) async {
      try {
        await announcementRepository.deleteAnnounce(event.id);
        final announcementAdmins =
            await announcementRepository.fetchAllAnnouncement();
        print("Successfully deleted and listed");
        emit(AnnouncementAdminOperationSuccess(announcementAdmins));
      } catch (_) {
        print(" delettion failed");
        emit(AnnouncementAdminOperationFailure());
        rethrow;
      }
    });
  }
}
