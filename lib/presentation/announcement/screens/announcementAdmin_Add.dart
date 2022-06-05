import 'package:go_router/go_router.dart';
import 'package:miesitu/application/announcement/bloc/announcement_blocs.dart';
import 'package:miesitu/domain/announcement/entity/announcement_model.dart';
import 'package:miesitu/gloabl/route_name_constants.dart';
import 'package:miesitu/presentation/announcement/screens/announcementAdmin_Edit.dart';
// import 'package:labpract/presentation/Admin_Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminAnnouncementAdd extends StatefulWidget {
  static const String routeName = '/adminannouncementadd';

  @override
  _AdminAnnouncementAddState createState() => _AdminAnnouncementAddState();
}

class _AdminAnnouncementAddState extends State<AdminAnnouncementAdd> {
  final Map<String, dynamic> _announcement = {};
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFffffff),

      body: Container(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.08,
                  ),
                  const Text(
                    'Wel Come To ',
                    style: TextStyle(color: Color(0xFF363f93), fontSize: 31),
                  ),
                  const Text(
                    'Announcement Page !!',
                    style: TextStyle(color: Color(0xFF363f93), fontSize: 31),
                  ),
                  SizedBox(
                    height: height * 0.12,
                  ),

                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Enter the Subject of the announcement",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter the subject of the  Announcement';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _announcement["subject"] = value;
                        });
                      }),
                  SizedBox(height: height * 0.06),

                  TextFormField(
                      // textAlign: TextAlign.right,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: "Enter the description",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter the subject of the  description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _announcement["description"] = value;
                        });
                      }),
                  SizedBox(height: height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.blue.withOpacity(0.04);
                                }
                                if (states.contains(MaterialState.focused) ||
                                    states.contains(MaterialState.pressed)) {
                                  return Colors.blue.withOpacity(0.12);
                                }
                                return null; 
                              },
                            ),
                          ),
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form != null && form.validate()) {
                              form.save();
                              final AnnouncementEvent event =
                                  AnnouncementAdminCreate(
                                Announcement(
                                  id: '',
                                  subject: _announcement["subject"],
                                  description: _announcement["description"],
                                ),
                              );
                              BlocProvider.of<AnnouncementBloc>(context)
                                  .add(event);
                              GoRouter.of(context)
                                  .goNamed(adminAnnouncementlist);
                             
                            }
                          },
                          child: const Text('Save',
                              style: TextStyle(
                                  color: Color(0xFF363f93),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ))
          ),
    );
  }
}
