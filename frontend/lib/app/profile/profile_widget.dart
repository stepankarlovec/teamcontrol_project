import 'dart:math';

import 'package:app/app/components/appBars.dart';
import 'package:app/app/profile/profile_service.dart';
import 'package:app/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/drawer.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  List<String> dataString = ["GK", "DF", "MF", "FW"];
  String? selectedString;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
      future: getProfile(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still loading, show a loading indicator
          return Scaffold(
            appBar: defaultAppBar(context, _scaffoldKey),
            drawer: buildDrawer(context),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // If there's an error in fetching the data, handle it here
          return Scaffold(
            appBar: defaultAppBar(context, _scaffoldKey),
            drawer: buildDrawer(context),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData) {
          // If the Future completed successfully but returned no data, handle it here
          return Scaffold(
            appBar: defaultAppBar(context, _scaffoldKey),
            drawer: buildDrawer(context),
            body: const Center(
              child: Text('No data available'),
            ),
          );
        } else {
          // If the Future completed successfully with data, use the fetched data to build the widget
          Profile profile = snapshot.data!;
          print(profile);
          // Set the initial values for your controllers and selectedString
          firstnameController.text = profile.firstName;
          lastnameController.text = profile.lastName;
          weightController.text = profile.weight.toString();
          heightController.text = profile.height.toString();
          selectedString = profile.position;

          return Scaffold(
            key: _scaffoldKey,
            appBar: defaultAppBar(context, _scaffoldKey),
            drawer: buildDrawer(context),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                      "Edit Profile",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff535252),
                      ),
                    ),
                    Container(
                      // Your existing container code...
                    ),
                    TextField(
                      controller: firstnameController,
                      // Your existing TextField code...
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 0),
                      child: TextField(
                        controller: lastnameController,
                        // Your existing TextField code...
                      ),
                    ),
                    TextField(
                      controller: heightController,
                      // Your existing TextField code...
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: TextField(
                        controller: weightController,
                        // Your existing TextField code...
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: CustomSingleSelectField<String>(
                        items: dataString,
                        title: "Position",
                        initialValue: selectedString,
                        onSelectionDone: (value) {
                          selectedString = value;
                          setState(() {});
                        },
                        itemAsString: (item) => item,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                      width: 16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          editProfile(
                            Profile(
                              firstName: firstnameController.text,
                              lastName: lastnameController.text,
                              height: int.parse(heightController.text),
                              weight: int.parse(weightController.text),
                              position: selectedString,
                            ),
                            context,
                          );
                        },
                        child: const Text("Save"),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                      width: 16,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.red,
                          ),
                        ),
                        onPressed: () {
                          // Your delete account logic...
                        },
                        child: TextButton(onPressed: () => {
                          logout(context)
                        },
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                            ),
                            child: Text("Logout")),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.red,
                          ),
                        ),
                        onPressed: () {
                          // Your delete account logic...
                        },
                        child: TextButton(onPressed: () => showDialog(context: context, builder: (BuildContext context)=>
                            AlertDialog(
                              title: const Text('Delete account'),
                              content: const Text('Are you sure you want to delete your account? You cannot undo this action!'),
                              actions: <Widget>[
                                TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text("Cancel")),
                                TextButton(onPressed: () => deleteAccount(context), child: const Text("Delete"), style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.red)
                                )),
                              ],
                            )
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.red)
                        ),
                        child: Text("Delete my account")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
