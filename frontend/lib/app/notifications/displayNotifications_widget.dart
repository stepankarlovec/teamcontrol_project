import 'package:app/app/homepage/homepage_service.dart';
import 'package:app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:app/app/admin/player/player_service.dart';
import 'package:app/app/apologies/apology_service.dart';
import 'package:app/app/event/displayPage/displayEvent_service.dart';
import 'package:app/models/UserForeign.dart';
import 'package:app/models/event.dart';
import 'package:provider/provider.dart';

import '../../config/utils.dart';
import '../../providers/provider_user.dart';
import '../admin/createNotification/createNotification_widget.dart';
import '../components/appBars.dart';
import '../components/drawer.dart';
import 'notificationDetail/DisplayMessageWidget.dart';

class DisplayNotificationWidget extends StatefulWidget {
  DisplayNotificationWidget({super.key});

  @override
  State<DisplayNotificationWidget> createState() => _DisplayNotificationWidgetState();
}

class _DisplayNotificationWidgetState extends State<DisplayNotificationWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Message> messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: defaultAppBar(context, _scaffoldKey),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
                future: getMessages(context),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(width: 80,
                        height: 80,
                        child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Provider.of<User>(context, listen: false).role>=1 ?
                        OutlinedButton(onPressed: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const CreateNotificationWidget()));
                        }, child: Text('New message')) : Text(""),
                        buildFutureEvents(context, snapshot)
                      ],
                    );
                  }
                })
        ),
      ),
    );
  }

  FutureBuilder<List<Message>> buildFutureEvents(BuildContext context,
      AsyncSnapshot<dynamic> snapshot) {
    return FutureBuilder(
        future: getMessages(context),
        builder: (context, AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            messageData = snapshot.data!;
            if(messageData.length==0){
              return Text("No new messages.");
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(messageData.length, (index) =>
                    Row(
                      children: [
                        Text(truncateText(messageData[index].message, 40) ?? ""),
                        Text("-"),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0),
                          child: TextButton(onPressed: () {
                            if (messageData[index] is Message) {

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DisplayMessageWidget(
                                        message: Message(
                                          message: messageData[index].message,
                                          team_id: messageData[index].team_id,
                                          user_id: messageData[index].user_id,
                                          user_name: messageData[index].user_name,
                                          id: messageData[index].id
                                        ),
                                      )
                              )
                              );

                            } else {
                              return null;
                            }
                          },
                            child: Text("Inspect"),
                          ),
                        ),
                      ],
                    )
                )
              ],
            );
          }
        }
    );
  }
}
