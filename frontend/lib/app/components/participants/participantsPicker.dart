// ParticipantModalScreen.dart

import 'package:app/app/components/participants/participantPicker_service.dart';
import 'package:app/models/UserForeign.dart';
import 'package:flutter/material.dart';

class ParticipantModalScreen extends StatefulWidget {
  final Function(List<UserForeign>) onParticipantsSelected;

  const ParticipantModalScreen({Key? key, required this.onParticipantsSelected}) : super(key: key);

  @override
  State<ParticipantModalScreen> createState() => _ParticipantModalState();
}

class _ParticipantModalState extends State<ParticipantModalScreen> {
  late Future<List<UserForeign>> usersFuture;
  late List<bool> checkedItems;
  late List<UserForeign> snapshotData;

  @override
  void initState() {
    super.initState();
    usersFuture = getUsers(context);
    checkedItems = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Select participants',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: usersFuture,
              builder: (context, AsyncSnapshot<List<UserForeign>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(width: 80, height: 80, child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  snapshotData = snapshot.data!;
                  checkedItems = List.generate(snapshotData.length, (index) => false);

                  return ListView.builder(
                    itemCount: snapshotData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return CheckboxListTile(
                            key: Key(snapshotData[index].ID.toString()),
                            title: Text("${snapshotData[index].person.firstName} ${snapshotData[index].person.lastName}"),
                            value: checkedItems[index],
                            onChanged: (bool? value) {
                              setState(() {
                                checkedItems[index] = value!;
                              });
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              List<UserForeign> selectedItems = [];
              for (int i = 0; i < checkedItems.length; i++) {
                if (checkedItems[i]) {
                  selectedItems.add(snapshotData[i]);
                }
              }
              print("Selected Items: $selectedItems");

              widget.onParticipantsSelected(selectedItems);
              Navigator.pop(context); // Close the modal
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
