import 'dart:math';

import 'package:flutter/material.dart';

class InputCondition {
  var input;
  String type;

  InputCondition({
    required this.input,
    required this.type,
  });
}

class InputValidator {
  List<InputCondition> inputs;

  InputValidator({required this.inputs});

  bool validateFields() {
    for (var condition in inputs) {
      if (condition.input is TextEditingController) {
        TextEditingController textController = condition.input;
        String text = textController.text.trim();
        print(text);
        // Check if the input is not empty
        if (text.isEmpty) {
          return false;
        }

        // Check if the input type matches the specified type
        switch (condition.type) {
          case 'email':
          // You can implement more specific type checks here
          // For example, checking if the text is a valid email
          // This is just a basic example, you may need to adjust it based on your requirements
            if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(text)) {
              return false;
            }
            break;
        // Add more cases for other types if needed
        // case 'anotherType':
        //   // Validate another type
        //   break;
          case 'text':
          break;
          case 'number':
            if(!RegExp(r'^-?\d+(\.\d*)?$').hasMatch(text)){
              print("LMAO");
              return false;
            }
            break;
          default:
          // If the type is not recognized, consider it invalid
            return false;
        }
      } else {
        // If the input is not a TextEditingController, consider it invalid
        return false;
      }
    }

    // All conditions passed, so consider the fields as valid
    return true;
  }
}
