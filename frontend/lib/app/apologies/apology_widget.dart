import 'package:app/app/apologies/apology_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/apology.dart';
import '../../providers/provider_user.dart';
import '../components/appBars.dart';
import '../components/datePicker.dart';
import '../components/drawer.dart';
import '../components/timePicker.dart';

class ApologyWidget extends StatefulWidget {
  const ApologyWidget({super.key});

  @override
  State<ApologyWidget> createState() => _ApologyState();
}

class _ApologyState extends State<ApologyWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TimeOfDay fromTimeController;
  late TimeOfDay untilTimeController;
  late DateTime fromDateController;
  late DateTime untilDateController;
  final textController = TextEditingController();

  void onNewTimeFrom(TimeOfDay newData){
    setState(() {
      fromTimeController = newData;
    });
  }
  void onNewDateFrom(DateTime newData){
    setState(() {
      fromDateController = newData;
    });
  }
  void onNewTimeUntil(TimeOfDay newData){
    setState(() {
      untilTimeController = newData;
    });
  }
  void onNewDateUntil(DateTime newData){
    setState(() {
      untilDateController = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
                    return Scaffold(
                        key: _scaffoldKey,
                        drawer: buildDrawer(context),
                        appBar: defaultAppBar(context, _scaffoldKey),
                        body: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('From',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 70,
                                  child: DatePicker(restorationId: 'main', callback: onNewDateFrom),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TimePickerOptions(
                                    callback: onNewTimeFrom,
                                    themeMode: ThemeMode.system,
                                    useMaterial3: true,
                                    setThemeMode: (ThemeMode value) {},
                                    setUseMaterial3: (bool? value) {},
                                  ),
                                ),
                                Text('Until',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 70,
                                  child: DatePicker(restorationId: 'main', callback: onNewDateUntil,),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TimePickerOptions(
                                    callback: onNewTimeUntil,
                                    themeMode: ThemeMode.system,
                                    useMaterial3: true,
                                    setThemeMode: (ThemeMode value) {},
                                    setUseMaterial3: (bool? value) {},
                                  ),
                                ),
                                TextField(
                                  controller: textController,
                                  obscureText: false,
                                  textAlign: TextAlign.start,
                                  minLines: 3,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                  decoration: InputDecoration(
                                      hintText: "Apology content",
                                      border: OutlineInputBorder()
                                    // ... Your TextField decoration
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      try {
                                        DateTime dateBefore = DateTime(
                                          fromDateController.year,
                                          fromDateController.month,
                                          fromDateController.day,
                                          fromTimeController.hour,
                                          fromTimeController.minute,
                                        );

                                        DateTime dateAfter = DateTime(
                                          untilDateController.year,
                                          untilDateController.month,
                                          untilDateController.day,
                                          untilTimeController.hour,
                                          untilTimeController.minute,
                                        );

                                        int providerUserId = Provider.of<User>(context, listen: false).ID ?? 0;
                                        createApology(Apology(name: 'Apology', dateFrom: dateBefore, dateUntil: dateAfter, text: textController.text, userId: providerUserId

                                        ), context);
                                      } catch (Err) {
                                        print(Err);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                        ));
  }
}
