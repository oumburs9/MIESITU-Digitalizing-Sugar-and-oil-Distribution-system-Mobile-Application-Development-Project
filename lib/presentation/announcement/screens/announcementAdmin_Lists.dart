import 'package:go_router/go_router.dart';
import 'package:miesitu/application/announcement/bloc/announcement_bloc.dart';
import 'package:miesitu/application/announcement/events/announcement_event.dart';
import 'package:miesitu/application/announcement/states/announcement_state.dart';
import 'package:miesitu/domain/announcement/entity/announcement_model.dart';
import 'package:miesitu/gloabl/route_name_constants.dart';
import 'package:miesitu/presentation/announcement/screens/announcementAdmin_Edit.dart';
import 'package:miesitu/presentation/common/slide_edit_and_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminAnnouncements extends StatefulWidget {
  static const routeName = '/adminannouncements';

  static Announcement editArg =
      Announcement(id: "", subject: "", description: "");

  const AdminAnnouncements({Key? key}) : super(key: key);

  @override
  _AdminAnnouncementsState createState() => _AdminAnnouncementsState();
}

class _AdminAnnouncementsState extends State<AdminAnnouncements> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
                builder: (_, state) {
                  if (state is AnnouncementAdminOperationFailure) {
                    return const Text('Could not Fetch');
                  }

                  if (state is AnnouncementAdminOperationSuccess) {
                    final announcements = state.announcement;

                    return ListView.builder(
                        itemCount: announcements.length,
                        itemBuilder: (_, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Dismissible(
                              background: slideRightToDelete(),
                              secondaryBackground: slideLeftToEdit(),
                              key: ValueKey<Announcement>(
                                  announcements.elementAt(index)),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  final bool res = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              "${announcements.elementAt(index).subject}?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                GoRouter.of(context).pop();
                                                // Navigator.pop(context, false);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  BlocProvider.of<
                                                              AnnouncementBloc>(
                                                          context)
                                                      .add(
                                                          AnnouncementAdminDelete(
                                                              announcements
                                                                  .elementAt(
                                                                      index)
                                                                  .id
                                                                  .toString()));
                                                  context.goNamed(
                                                      adminProductList);
                                                  // Navigator.of(context)
                                                  //     .pushNamedAndRemoveUntil(
                                                  //         AdminAnnouncements
                                                  //             .routeName,
                                                  //         (route) => false);
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                  return res;
                                } else if (direction ==
                                    DismissDirection.startToEnd) {
                                  AdminAnnouncements.editArg =
                                      announcements.elementAt(index);
                                  Navigator.of(context).pushNamed(
                                      AdminAnnouncementEdit.routeName,
                                      arguments:
                                          announcements.elementAt(index));
                                }
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 4,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: ListTile(
                                    title: Text(
                                      announcements.elementAt(index).subject,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    contentPadding: const EdgeInsets.all(5),
                                    subtitle: Text(
                                      announcements
                                          .elementAt(index)
                                          .description,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    trailing: Container(
                                        width: width * 0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                context
                                                    .goNamed(adminProductEdit, extra:announcements);
                                              },
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Text(
                                                            "${announcements.elementAt(index).subject}?"),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  false);
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                BlocProvider.of<
                                                                            AnnouncementBloc>(
                                                                        context)
                                                                    .add(AnnouncementAdminDelete(announcements
                                                                        .elementAt(
                                                                            index)
                                                                        .id
                                                                        .toString()));
                                                                        GoRouter.of(context).goNamed(adminAnnouncementlist);
                                                    
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              //  AnnouncementCard(
                              //   announcementSubject:
                              //       announcements.elementAt(index).subject,
                              //   announcementDescription:
                              //       announcements.elementAt(index).description,
                              // children: [

                              // ],
                            ),
                            // ),
                          );
                        });
                  }

                  return const Center(
                      child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ));
                },
              ),
            )
          ],
          // create: () => Navigator.of(context).pushNamed(
          //   AdminAnnouncementAdd.routeName,
        ),
      ),
    );
  }
}

// class AnnouncementCard extends StatelessWidget {
//   final String announcementSubject;
//   final String announcementDescription;
//   final List<Widget>? children;
//   const AnnouncementCard(
//       {Key? key,
//       required this.announcementSubject,
//       required this.announcementDescription,
//       this.children})
//       : super(key: key);

//   // get children => null;

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Card(
//           margin: const EdgeInsets.symmetric(
//             horizontal: 15,
//             vertical: 4,
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(8),
//             child: ListTile(
//               title: Text(
//                 announcementSubject,
//                 style:
//                     const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//               contentPadding: const EdgeInsets.all(5),
//               subtitle: Text(
//                 announcementDescription,
//                 style:
//                     const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
//               ),
//               trailing: Container(
//                   width: width * 0.3,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ...?children,
//                     ],
//                   )),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
