import 'package:app/app/homepage/homepage.dart';
import 'package:app/app/noTeam/join_team_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/profile.dart';
import '../../../providers/provider_user.dart';
import '../../event/newEvent/new_event_service.dart';
import '../../noProfile/noprofile_widget.dart';
import 'create_team_service.dart';

class CreateTeamWidget extends StatefulWidget {
  const CreateTeamWidget({super.key});

  @override
  State<CreateTeamWidget> createState() => _CreateTeamWidgetState();
}

class _CreateTeamWidgetState extends State<CreateTeamWidget> {
  String country = "";
  final nameInputController = TextEditingController();

  void updateCountry(String val) {
    setState(() {
      country = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create a team", style: TextStyle(fontSize: 36)),
            TextField(
                controller: nameInputController,
                decoration: const InputDecoration(
                  hintText: 'Team name',
                )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(country),
                TextButton(
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      favorite: <String>['CZ', 'SK'],
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        updateCountry(country.name);
                      },
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        // Optional. Sets the border radius for the bottomsheet.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  child: const Text('Choose country'),
                ),
              ],
            ),
            ElevatedButton(onPressed: () {
              createTeamRequest(Provider.of<User>(context, listen:false).bearerToken, nameInputController.text, country, context);
              if(getProfile(context) is Profile){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Homepage()));
              }else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NoProfileWidget()));
              }
            }, child: const Text("Create")),
            const SizedBox(height: 40),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const JoinTeamWidget()));
                },
                child: const Text("Join existing team"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
