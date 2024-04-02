import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/apology.dart';
import '../../../providers/provider_user.dart';
import '../../components/appBars.dart';
import '../../components/drawer.dart';
import 'apologyList_service.dart';

class DisplayApologyWidget extends StatefulWidget {
  final Apology apology;
  const DisplayApologyWidget({super.key, required this.apology});

  @override
  State<DisplayApologyWidget> createState() => _DisplayApologyState();
}

class _DisplayApologyState extends State<DisplayApologyWidget> {
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
                        OutlinedButton(onPressed: (){ deleteApology(context, widget.apology.id! ); }, child: Text("Delete"), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.red))),
                        //OutlinedButton(onPressed: (){return null;}, child: Text("Edit")),
                      ],
                    ),
                  ) : Text(""),
                  Center(
                    child: Column(
                      children: [
                        Text(widget.apology.userId.toString(), style: TextStyle(
                            fontSize: 20
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.apology.text, style: TextStyle(
                              fontSize: 20
                          ),),
                        ),
                        Text("${widget.apology.dateFrom.day}/${widget.apology.dateFrom.month}/${widget.apology.dateFrom.year} ${widget.apology.dateFrom.hour.toString().padLeft(2,'0')}:${widget.apology.dateFrom.minute.toString().padLeft(2,'0')}", style: TextStyle(
                            fontSize: 20
                        )),
                        Text("-"),
                        Text("${widget.apology.dateUntil.day}/${widget.apology.dateUntil.month}/${widget.apology.dateUntil.year} ${widget.apology.dateUntil.hour.toString().padLeft(2,'0')}:${widget.apology.dateUntil.minute.toString().padLeft(2,'0')}", style: TextStyle(
                            fontSize: 20
                        )),
                      ],
                    ),
                  ),]
            )));
  }
}