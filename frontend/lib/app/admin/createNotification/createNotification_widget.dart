
import 'package:app/app/admin/createNotification/createNotification_service.dart';
import 'package:app/app/profile/profile_service.dart';
import 'package:app/config/InputValidator.dart';
import 'package:app/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';

import '../../components/appBars.dart';
import '../../components/drawer.dart';

class CreateNotificationWidget extends StatefulWidget {
  const CreateNotificationWidget({super.key});

  @override
  State<CreateNotificationWidget> createState() => _CreateNotificationWidgetState();
}

class _CreateNotificationWidgetState extends State<CreateNotificationWidget> {
  final messageController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: defaultAppBar(context, _scaffoldKey),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 33, horizontal: 16),
        child: SingleChildScrollView(
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
                "Create new message",
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
                controller: messageController,
                obscureText: false,
                textAlign: TextAlign.start,
                maxLines: 3,
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
                  labelText: "Your message...",
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
              const SizedBox(
                height: 16,
                width: 16,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: (){
                      createMessage(messageController.text, context);
                    },
                    child: const Text("Send"),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
