
import 'package:app/app/profile/profile_service.dart';
import 'package:app/config/InputValidator.dart';
import 'package:app/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';

import '../components/drawer.dart';

class NoProfileWidget extends StatefulWidget {
  const NoProfileWidget({super.key});

  @override
  State<NoProfileWidget> createState() => _profileWidgetState();
}

class _profileWidgetState extends State<NoProfileWidget> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();


  List<String> dataString = [
    "GK", "DF", "MF", "FW"
  ];
  String? selectedString;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    getProfile(context).then((value){
      firstnameController.text=value.firstName;
      lastnameController.text=value.lastName;
      weightController.text=value.weight.toString();
      heightController.text=value.height.toString();
      selectedString=value.position;
    });


    return Scaffold(
      key: _scaffoldKey,
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
                "Setup your profile",
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
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 30),
                padding: const EdgeInsets.all(0),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0x1f000000),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child: Container(
                  height: 120,
                  width: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text("?")),
                ),
              ),
              TextField(
                controller: firstnameController,
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
                  labelText: "First Name",
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: TextField(
                  controller: lastnameController,
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
                      borderSide:
                      const BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                      const BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                      const BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    labelText: "Last Name",
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
              ),
              TextField(
                controller: heightController,
                obscureText: false,
                textAlign: TextAlign.start,
                maxLines: 1,
                keyboardType: TextInputType.number,
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
                  labelText: "Height (cm)",
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: TextField(
                  controller:
                  weightController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                      const BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                      const BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                      const BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    labelText: "Weight (kg)",
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
              ),

              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                child: CustomSingleSelectField<String>(
                  items: dataString,
                  title: "Position",
                  initialValue: selectedString,
                  onSelectionDone: (value){
                    selectedString = value;
                    setState(() {});
                  },
                  itemAsString: (item)=>item,
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
                    if(InputValidator(inputs: [
                      InputCondition(input: firstnameController, type: 'text'),
                      InputCondition(input: lastnameController, type: 'text'),
                      InputCondition(input: heightController, type: 'number'),
                      InputCondition(input: weightController, type: 'number')
                    ]).validateFields()) {
                      editProfile(Profile(firstName: firstnameController.text,
                          lastName: lastnameController.text,
                          height: int.parse(heightController.text),
                          weight: int.parse(weightController.text),
                          position: selectedString), context,);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Wrong values in fields!"),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                      ));
                    }
                  },
                  child: const Text("Save"),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
