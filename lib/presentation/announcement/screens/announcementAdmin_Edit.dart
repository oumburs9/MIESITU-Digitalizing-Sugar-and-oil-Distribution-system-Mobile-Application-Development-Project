import 'package:miesitu/application/announcement/events/announcement_event.dart';
import 'package:miesitu/application/announcement/bloc/announcement_bloc.dart';
import 'package:miesitu/domain/announcement/entity/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminAnnouncementEdit extends StatefulWidget {
  static const String routeName = '/adminannouncementedit';

  final Announcement? announcement;
  AdminAnnouncementEdit({this.announcement});

  @override
  _AdminAnnouncementEditState createState() => _AdminAnnouncementEditState();
}

class _AdminAnnouncementEditState extends State<AdminAnnouncementEdit> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _announcement = {};

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.06),
                      TextFormField(
                          initialValue: widget.announcement!.subject,
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
                          // textAlign: TextAlign.center,
                          initialValue: widget.announcement!.description,
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
                      const SizedBox(
                        height: 30.0,
                      ),
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
                                  return null; // Defer to the widget's default.
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
                                    id: widget.announcement!.id,
                                    // id: "",
                                    subject: _announcement["subject"],
                                    description: _announcement["description"],
                                  ),
                                );
                                BlocProvider.of<AnnouncementBloc>(context)
                                    .add(event);
                                // Navigator.of(context)
                                //     .pushNamedAndRemoveUntil(
                                //         AdminMachineries.routeName,
                                //         (route) => false);
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  color: Color(0xFF363f93),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))),
        )));
  }
}
