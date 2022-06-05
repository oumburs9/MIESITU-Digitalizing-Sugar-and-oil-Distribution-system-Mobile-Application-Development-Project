import 'package:labpract/application/announcement/bloc/announcement_blocs.dart';
import 'package:labpract/domain/announcement/entity/announcement_model.dart';
import 'package:labpract/infrastructure/announcement/repository/announcement_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mocktail/mocktail.dart';

class MockAnnouncementBloc
    extends MockBloc<AnnouncementEvent, AnnouncementState>
    implements AnnouncementBloc {}

class MockAnnouncementRepository extends Mock
    implements AnnouncementRepository {}

void main() {
  MockAnnouncementRepository announcementRepository =
      MockAnnouncementRepository();

  final announcement = Announcement(
    id: "1",
    subject: 'Oil',
    description: 'New arrival',
  );
  Future<List<Announcement>> createAnnouncements() async {
    return [
      Announcement(
        id: "1",
        subject: 'Oil',
        description: 'New arrival',
      )
    ];
  }

  Future<Announcement> createAnnouncement() async {
    return Announcement(
      id: "1",
      subject: 'Oil',
      description: 'New arrival',
    );
  }

  ;

  setUp(() {
    announcementRepository = MockAnnouncementRepository();
  });

  blocTest<AnnouncementBloc, AnnouncementState>(
      'emits [announcementLoading,announcementAdminOperationSuccess] when successful',
      build: () {
        when(() => announcementRepository.fetchAllAnnouncement())
            .thenAnswer((invocation) => createAnnouncements());
        return AnnouncementBloc(announcementRepository: announcementRepository);
      },
      act: (bloc) => bloc.add(AnnouncementAdminLoad()),
      expect: () {
        return [
          AnnouncementAdminLoading(),
          isA<AnnouncementAdminOperationSuccess>()
        ];
      });

  blocTest<AnnouncementBloc, AnnouncementState>(
      'emits [announcementLoading,announcementAdminOperationFailure] when unsuccessful',
      build: () {
        return AnnouncementBloc(announcementRepository: announcementRepository);
      },
      act: (bloc) => bloc.add(AnnouncementAdminLoad()),
      expect: () {
        return [
          AnnouncementAdminLoading(),
          AnnouncementAdminOperationFailure()
        ];
      });

  blocTest<AnnouncementBloc, AnnouncementState>(
      'emits [announcementLoading,announcementAdminOperationSuccess] when successful',
      build: () {
        when(() => announcementRepository.createAnnounce(announcement))
            .thenAnswer((invocation) => createAnnouncement());
        when(() => announcementRepository.fetchAllAnnouncement())
            .thenAnswer((invocation) => createAnnouncements());
        return AnnouncementBloc(announcementRepository: announcementRepository);
      },
      act: (bloc) => bloc.add(AnnouncementAdminCreate(announcement)),
      expect: () {
        return [isA<AnnouncementAdminOperationSuccess>()];
      });

  blocTest<AnnouncementBloc, AnnouncementState>(
      'emits [ProductAdminOperationSuccess] when successful',
      build: () {
        when(() => announcementRepository.updateAnnounce("1", announcement))
            .thenAnswer((invocation) => createAnnouncement());
        when(() => announcementRepository.fetchAllAnnouncement())
            .thenAnswer((invocation) => createAnnouncements());
        return AnnouncementBloc(announcementRepository: announcementRepository);
      },
      act: (bloc) => bloc.add(AnnouncementAdminUpdate(announcement)),
      expect: () {
        return [isA<AnnouncementAdminOperationSuccess>()];
      });

  blocTest<AnnouncementBloc, AnnouncementState>(
      'emits [productAdminOperationSuccess] when successful',
      build: () {
        when(() => announcementRepository.deleteAnnounce("1"))
            .thenAnswer((invocation) => createAnnouncement());
        when(() => announcementRepository.fetchAllAnnouncement())
            .thenAnswer((invocation) => createAnnouncements());
        return AnnouncementBloc(announcementRepository: announcementRepository);
      },
      act: (bloc) => bloc.add(AnnouncementAdminDelete("1")),
      expect: () {
        return [isA<AnnouncementAdminOperationSuccess>()];
      });
}
