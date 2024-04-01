
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/message.dart';
import '../../../providers/provider_user.dart';
import '../../components/appBars.dart';
import '../../components/drawer.dart';
import '../displayNotifications_service.dart';

class DisplayMessageWidget extends StatefulWidget {
  final Message message;
  const DisplayMessageWidget({super.key, required this.message});

  @override
  State<DisplayMessageWidget> createState() => _DisplayMessageState();
}

class _DisplayMessageState extends State<DisplayMessageWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: buildDrawer(context),
        appBar: AppBarBack(context, _scaffoldKey),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  Provider.of<User>(context, listen: false).role>=1 ?
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(onPressed: (){ deleteMessage(context, widget.message.id! ); }, child: Text("Delete"), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.red))),
                      ],
                    ),
                  ) : Text(""),
                  Center(
                    child: Column(
                      children: [
                        Text(widget.message.user_name!, style: TextStyle(
                            fontSize: 15
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.message.message!, style: TextStyle(
                              fontSize: 20
                          ),),
                        ),
                      ],
                    ),
                  ),]
            )));
  }
}