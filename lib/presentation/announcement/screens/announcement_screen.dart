import 'package:miesitu/application/announcement/states/announcement_state.dart';
import 'package:miesitu/application/announcement/bloc/announcement_bloc.dart';
import 'package:miesitu/domain/announcement/entity/announcement_model.dart';
// import 'package:labpract/presentation/announcements/screens/announcementAdmin_Lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.5,
            //15
          ),
          Expanded(
            child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
              builder: (_, state) {
                if (state is AnnouncementAdminOperationFailure) {
                  return const Text('Error: Displaying announcement list');
                }

                if (state is AnnouncementAdminOperationSuccess) {
                  final announcement = state.announcement;

                  return ListView.builder(
                      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      //     maxCrossAxisExtent: 3,
                      //     childAspectRatio: 3 / 2,
                      //     crossAxisSpacing: 20,
                      //     mainAxisSpacing: 20),
                      itemCount: announcement.length.toInt(),
                      itemBuilder: (_, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          key: ValueKey<Announcement>(
                              announcement.elementAt(index)),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 25),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      topRight: Radius.circular(50)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white70,
                                        offset: Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0),
                                  ]),
                              padding: const EdgeInsets.only(
                                  left: 32, top: 50.0, bottom: 50.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(announcement.elementAt(index).subject,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold)),
                                  Divider(
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    height: height * 0.3,
                                    //  5,
                                  ),
                                  Text(
                                      announcement.elementAt(index).description,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }

                return Center(
                    child: SizedBox(
                  width: width * 0.5,
                  height: height * 0.5,
                  child: CircularProgressIndicator(
                    color: Colors.black26,
                  ),
                ));
              },
            ),
          )
        ],
      ),
    );
  }
}
