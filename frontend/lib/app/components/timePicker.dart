import 'package:flutter/material.dart';

class TimePickerOptions extends StatefulWidget {
  const TimePickerOptions({
    super.key,
    required this.callback,
    required this.themeMode,
    required this.useMaterial3,
    required this.setThemeMode,
    required this.setUseMaterial3,
  });

  final Function(TimeOfDay) callback;
  final ThemeMode themeMode;
  final bool useMaterial3;
  final ValueChanged<ThemeMode> setThemeMode;
  final ValueChanged<bool?> setUseMaterial3;

  @override
  State<TimePickerOptions> createState() => _TimePickerOptionsState();
}

class _TimePickerOptionsState extends State<TimePickerOptions> {
  TimeOfDay? selectedTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.inputOnly;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = true;

  void _entryModeChanged(TimePickerEntryMode? value) {
    if (value != entryMode) {
      setState(() {
        entryMode = value!;
      });
    }
  }

  void _orientationChanged(Orientation? value) {
    if (value != orientation) {
      setState(() {
        orientation = value;
      });
    }
  }

  void _textDirectionChanged(TextDirection? value) {
    if (value != textDirection) {
      setState(() {
        textDirection = value!;
      });
    }
  }

  void _tapTargetSizeChanged(MaterialTapTargetSize? value) {
    if (value != tapTargetSize) {
      setState(() {
        tapTargetSize = value!;
      });
    }
  }

  void _use24HourTimeChanged(bool? value) {
    if (value != use24HourTime) {
      setState(() {
        use24HourTime = value!;
      });
    }
  }

  void _themeModeChanged(ThemeMode? value) {
    widget.setThemeMode(value!);
  }

  void valueChanged(val){
    print("GOGOMANTV IS BOSS");
    widget.callback(val);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              OutlinedButton(
                child: const Text('Choose time'),
                onPressed: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                    initialEntryMode: entryMode,
                    orientation: orientation,
                    builder: (BuildContext context, Widget? child) {
                      // We just wrap these environmental changes around the
                      // child in this builder so that we can apply the
                      // options selected above. In regular usage, this is
                      // rarely necessary, because the default values are
                      // usually used as-is.
                      return Theme(
                        data: Theme.of(context).copyWith(
                          materialTapTargetSize: tapTargetSize,
                        ),
                        child: Directionality(
                          textDirection: textDirection,
                          child: MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              alwaysUse24HourFormat: true,
                            ),
                            child: child!,
                          ),
                        ),
                      );
                    },
                  );
                  setState(() {
                    selectedTime = time;
                    valueChanged(selectedTime);
                    //EventTimeChanged(selectedTime!).dispatch(context);
                  });
                },
              ),
            ],
          ),
          if (selectedTime != null)
            Text('Selected time: ${selectedTime!.format(context)}', ),
        ],
      ),
    );
  }
}


class EventTimeChanged extends Notification {
  final TimeOfDay val;
  EventTimeChanged(this.val);
}
