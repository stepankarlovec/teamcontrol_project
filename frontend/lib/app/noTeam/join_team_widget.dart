import 'package:app/app/noTeam/createTeam/create_team_widget.dart';
import 'package:flutter/material.dart';

import 'join_team_service.dart';



class JoinTeamWidget extends StatefulWidget{
  const JoinTeamWidget({super.key});

  @override
  State<JoinTeamWidget> createState() => _CreateTeamWidgetState();
}

class _CreateTeamWidgetState extends State<JoinTeamWidget> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Join team", style: TextStyle(fontSize: 36)),
            const SizedBox(height: 10),
            TextField(
                controller: codeController,
                decoration: InputDecoration(
                  hintText: 'Invitation Code',
                )),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              CodeVerifyRequest(codeController.text, context);
            }, child: const Text("Join")),
            const SizedBox(height: 40),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateTeamWidget()));
                },
                child: const Text("Create a new team"),
              ),
            )
          ],
        ),
      ),
    );
  }
}