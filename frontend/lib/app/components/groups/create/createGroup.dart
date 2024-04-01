import 'package:app/app/components/groups/create/createGroup_service.dart';
import 'package:flutter/material.dart';

import '../../../../models/UserForeign.dart';
import '../../../../models/group.dart';
import '../../appBars.dart';
import '../../drawer.dart';
import '../../participants/participantsPicker.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  class _CreateGroupState extends State<CreateGroup> {
    List<UserForeign> selectedParticipants = [];
    final nameInputController = TextEditingController();

    void _handleParticipantsSelected(List<UserForeign> participants) {
      setState(() {
        selectedParticipants = participants;
      });
    }

    void _showParticipantModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ParticipantModalScreen(onParticipantsSelected: _handleParticipantsSelected);
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: defaultAppBar(context, _scaffoldKey),
        drawer: buildDrawer(context),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: nameInputController,
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
                  disabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  labelText: "Name of the group",
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff6f6d6d),
                  ),
                  hintText: "Enter Text",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  filled: true,
                  fillColor: const Color(0x00ffffff),
                  isDense: false,
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                ),
              ),
              OutlinedButton(onPressed: (){_showParticipantModal(context);}, child: const Text('Select users')),
              Align(
                alignment: Alignment.bottomRight,
                child: OutlinedButton(onPressed: (){
                  createGroup(Group(name: nameInputController.text,permanent: 1, users: selectedParticipants.map((user) => user.ID.toString()).join(';')), context);
                }, child: const Text('Create'))
              )
            ],
          ),
        )
    );
  }
}