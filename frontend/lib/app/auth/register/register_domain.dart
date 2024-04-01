
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/provider_user.dart';
import '../../loading/loading_service.dart';
import '../../noTeam/createTeam/create_team_widget.dart';
import 'register_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterDomain {
  static Future<void> handleRegistration(
    BuildContext context,
    TextEditingController emailInputController,
    TextEditingController passwordInputController,
    TextEditingController passwordAgainInputController,
  ) async {
    final email = emailInputController.text;
    final password = passwordInputController.text;
    final passwordAgain = passwordAgainInputController.text;

    final scaffoldContext = context; // Capture the context here


    if(passwordAgain!=password) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text("Passwords don't match"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ));
      return;
    }
    try {
      final registrationResult = await createLoginRequest(email, password);
      if (registrationResult.success) {
        if (context.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
            content: Text(registrationResult.message),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ));
          const storage = FlutterSecureStorage();
          await storage.write(key: 'jwt', value: registrationResult.token);
          tryToAuth(context, registrationResult.token).then((UserAuthDataModel res) {
            context.read<User>().update(res);
            Navigator.of(scaffoldContext).push(
                MaterialPageRoute(builder: (context) => const CreateTeamWidget()));
          });
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
            content: Text(registrationResult.error),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
          content: Text('An error occurred: $e'),
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }
}
