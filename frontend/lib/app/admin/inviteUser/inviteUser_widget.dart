import 'package:app/app/admin/inviteUser/inviteUser_service.dart';
import 'package:app/app/auth/login/login_domain.dart';
import 'package:app/pages/RegisterPage.dart';
import 'package:flutter/material.dart';

import '../../../models/invitation.dart';
import '../../components/appBars.dart';
import '../../components/drawer.dart';

class InviteUserWidget extends StatefulWidget {
  const InviteUserWidget({Key? key}) : super(key: key);

  @override
  State<InviteUserWidget> createState() => _InviteUserState();
}

class _InviteUserState extends State<InviteUserWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Invitation code = Invitation(code: "");

  void fetchTheCode() async {
    try {
      // Call the getInvitationCode method directly
      code = await getInvitationCode(context);

      // Trigger a rebuild of the UI to display the new code
      setState(() {});
    } catch (error) {
      // Handle errors here
      print('Error fetching code: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: defaultAppBar(context, _scaffoldKey),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text("INVITATION CODE:", style: TextStyle(fontSize: 18)),
                // Use code directly in SelectableText
                SelectableText(
                  code != null ? code.code : "", // Use the code if available
                  style: TextStyle(fontSize: 35),
                ),
                TextButton(onPressed: fetchTheCode, child: Text("Generate new code:")),
                Text("Hold the text so you can copy it."),
                Text("You can optionally send an email:"),
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22, top: 8, bottom: 8),
                  child: TextField(decoration: InputDecoration(hintText: "E-mail")),
                ),
                OutlinedButton(onPressed: () {/* Handle email sending */}, child: Text("Send email"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
