import 'package:app/app/event/displayPage/displayEvent_service.dart';
import 'package:app/app/event/editEvent/edit_event_widget.dart';
import 'package:app/models/UserForeign.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/event.dart';
import '../../../providers/provider_user.dart';
import '../../components/appBars.dart';
import '../../components/drawer.dart';

class DisplayEventWidget extends StatefulWidget {
  final Event event;
  const DisplayEventWidget({super.key, required this.event});

  @override
  State<DisplayEventWidget> createState() => _DisplayEventState();
}

class _DisplayEventState extends State<DisplayEventWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<UserForeign>> usersFuture;
  late List<UserForeign> snapshotData;



  @override
  Widget build(BuildContext context) {
    print("this is the event id broski");
    print(widget.event.id ?? "lol");
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
                      OutlinedButton(onPressed: (){ deleteEvent(context, widget.event.id!); }, child: Text("Delete"), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.red))),
                      OutlinedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditEventWidget(event: widget.event)));
                      }, child: Text("Edit")),
                    ],
                  ),
                ) : Text(""),
                Center(
                child: Column(
                  children: [
                    Text(widget.event.name, style: TextStyle(
                      fontSize: 35
                    ),),
                    Text(widget.event.location, style: TextStyle(
                        fontSize: 20
                    )),
                    Text(widget.event.date.day.toString() + "/" + widget.event.date.month.toString() + "/" + widget.event.date.year.toString(), style: TextStyle(
                        fontSize: 20
                    )),
                    Text(widget.event.date.hour.toString().padLeft(2,'0') + ":" + widget.event.date.minute.toString().padLeft(2,'0'), style: TextStyle(
                        fontSize: 20
                    )),
                    Text(widget.event.duration.toString() + " minutes", style: TextStyle(
                        fontSize: 20
                    )),
                    //TextButton(onPressed: (){return null;}, child: Text("Participants"),)
                  ],
                ),
              ),]
            )));
  }
}