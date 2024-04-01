// ParticipantModalScreen.dart

import 'package:app/app/components/groups/groupPicker_service.dart';
import 'package:flutter/material.dart';

import '../../../models/group.dart';
import 'create/createGroup.dart';

class GroupModalScreen extends StatefulWidget {
  final Function(Group) onParticipantsSelected;

  const GroupModalScreen({Key? key, required this.onParticipantsSelected}) : super(key: key);

  @override
  State<GroupModalScreen> createState() => _GroupModalState();
}

class _GroupModalState extends State<GroupModalScreen> {
  late Future<List<Group>> groupsFuture;
  int? selectedRadioTile; // Initialize with null
  late List<Group> snapshotData;

  @override
  void initState() {
    super.initState();
    groupsFuture = getGroups(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select a group',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateGroup()));
                  },
                  child: const Text('New'),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: groupsFuture,
              builder: (context, AsyncSnapshot<List<Group>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(width: 80, height: 80, child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  snapshotData = snapshot.data!;
                  // Move the initialization outside the FutureBuilder
                  selectedRadioTile = selectedRadioTile ?? 0; // Initialize to the first item

                  print('Snapshot Data Length: ${snapshotData.length}');
                  print('Selected Radio Tile: $selectedRadioTile');

                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(snapshotData.length, (index) {
                        return RadioListTile(
                          key: Key(snapshotData[index].id.toString()),
                          title: Text(snapshotData[index].name),
                          value: index,
                          groupValue: selectedRadioTile,
                          onChanged: (int? value) {
                            print('OnChanged: $value');
                            setState(() {
                              selectedRadioTile = value;
                            });
                          },
                        );
                      }),
                    ),
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if(snapshotData.isNotEmpty) {
                if (selectedRadioTile != null) {
                  Group selectedItems = snapshotData[selectedRadioTile!];
                  print("Selected Item: $selectedItems");
                  widget.onParticipantsSelected(selectedItems);
                  Navigator.pop(context); // Close the modal
                } else {
                  print('No item selected');
                }
              }else{
                Navigator.pop(context); // Close the modal
              }
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
