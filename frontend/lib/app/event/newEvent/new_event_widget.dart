import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../../models/UserForeign.dart';
import '../../../models/event.dart';
import '../../../models/group.dart';
import '../../../providers/provider_user.dart';
import '../../components/appBars.dart';
import '../../components/datePicker.dart';
import '../../components/drawer.dart';
import '../../components/groups/groupPicker.dart';
import '../../components/participants/participantsPicker.dart';
import '../../components/timePicker.dart';
import 'new_event_service.dart';

class NewEventWidget extends StatefulWidget {
  const NewEventWidget({Key? key}) : super(key: key);

  @override
  State<NewEventWidget> createState() => _NewEventWidgetState();
}

class _NewEventWidgetState extends State<NewEventWidget> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final durationController = TextEditingController();
  var repeated = false;
  late DateTime dateController;
  late TimeOfDay timeController;
  Color pickerColor = const Color(0xff443a49);
  List<UserForeign> selectedParticipants = [];
  Group? selectedGroups;
  int groupOrParticipants = 0;

  void _handleParticipantsSelected(List<UserForeign> participants) {
    setState(() {
      selectedParticipants = participants;
    });
  }

  void _handleGroupsSelected(Group groupsParticipants) {
    setState(() {
      selectedGroups = groupsParticipants;
    });
  }

  void _showParticipantModal(BuildContext context) {
    setState(() {
      selectedGroups = null;
      groupOrParticipants = 1;
    });
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ParticipantModalScreen(onParticipantsSelected: _handleParticipantsSelected);
      },
    );
  }

  void _showGroupModal(BuildContext context) {
    setState(() {
      selectedParticipants = [];
      groupOrParticipants = 2;
    });
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GroupModalScreen(onParticipantsSelected: _handleGroupsSelected);
      },
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void onNewTime(TimeOfDay tod){
    setState(() {
      timeController = tod;
    });
  }

  void onNewDate(DateTime dt){
    setState(() {
      dateController = dt;
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: defaultAppBar(context, _scaffoldKey),
          drawer: buildDrawer(context),
          body: Builder(
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 16,
                        width: 16,
                      ),
                      const Text(
                        "Create event",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff535252),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                            hintText: "Event name"
                          // ... Your TextField decoration
                        ),
                      ),
                      TextField(
                        controller: locationController,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                            hintText: "Location"
                          // ... Your TextField decoration
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Column(
                        children: [
                            Align(alignment: Alignment.centerLeft,child: Text("Start:", style: TextStyle(fontSize: 18))),
                            SizedBox(
                              height: 50,
                              child: DatePicker(
                                  restorationId: 'main', callback: onNewDate),
                            ),
                            SizedBox(
                              height: 50,
                              child: TimePickerOptions(
                                callback: onNewTime,
                                themeMode: ThemeMode.system,
                                useMaterial3: true,
                                setThemeMode: (ThemeMode value) {},
                                setUseMaterial3: (bool? value) {},
                              ),
                            )]),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 120,
                                    child: TextField(
                                      controller: durationController,
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                      ),
                                      decoration: InputDecoration(
                                          hintText: "Duration (min)",
                                        // ... Your TextField decoration
                                      ),
                                    ),
                                  ),
                                ),
                                Checkbox(value: repeated, onChanged: (bool? value) {setState(() {repeated = value!;});}),
                                Text("Repeat every week?")
                              ],
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    _showParticipantModal(context);
                                  },
                                  style: ButtonStyle(backgroundColor: groupOrParticipants==1 ? MaterialStateProperty.all(Colors.purple) : MaterialStateProperty.all(Colors.white), foregroundColor: groupOrParticipants==1 ? MaterialStateProperty.all(Colors.white) : MaterialStateProperty.all(Colors.purple)),
                                  child: const Text('Choose participants'),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    _showGroupModal(context);
                                  },
                                  style: ButtonStyle(backgroundColor: groupOrParticipants==2 ? MaterialStateProperty.all(Colors.purple) : MaterialStateProperty.all(Colors.white), foregroundColor: groupOrParticipants==2 ? MaterialStateProperty.all(Colors.white) : MaterialStateProperty.all(Colors.purple)),
                                  child: const Text('Choose groups'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              int providerUserId = Provider
                                  .of<User>(context, listen: false)
                                  .ID ?? 0;
                              DateTime dt = DateTime(
                                dateController.year,
                                dateController.month,
                                dateController.day,
                                timeController.hour,
                                timeController.minute,
                              );
                              createEvent(
                                Event(
                                  name: nameController.text,
                                  date: dt,
                                  duration: int.parse(durationController.text),
                                  repeated: repeated==false?0:1,
                                  location: locationController.text,
                                  creator_id: providerUserId,
                                  color: pickerColor.toString(),
                                  groups: selectedGroups is Group
                                      ? selectedGroups?.id.toString()
                                      : null,
                                  individualParticipants: selectedParticipants
                                      .isNotEmpty
                                      ? selectedParticipants.map((user) =>
                                      user.ID.toString()).join(';')
                                      : '',
                                ),
                                context,
                              );
                            } catch (Err) {
                              print(Err);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Error - Please check all the fields are correct."),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: const Text("Create"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        );
  }
}

class AlertDialogColor extends StatefulWidget {
  const AlertDialogColor({Key? key}) : super(key: key);

  @override
  State<AlertDialogColor> createState() => _NewAlertDialogColor();
}

class _NewAlertDialogColor extends State<AlertDialogColor> {
  Color pickerColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose event color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
