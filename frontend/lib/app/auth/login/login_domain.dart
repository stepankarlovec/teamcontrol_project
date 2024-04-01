
import 'package:app/app/homepage/homepage.dart';
import 'package:flutter/material.dart';
import '../../../models/profile.dart';
import '../../../providers/provider_user.dart';
import '../../event/newEvent/new_event_service.dart';
import '../../loading/loading_service.dart';
import '../../noProfile/noprofile_widget.dart';
import '../../noTeam/createTeam/create_team_widget.dart';
import 'login_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginDomain{

  static Future<void> handleLogin(
      BuildContext context,
      TextEditingController emailInputController,
      TextEditingController passwordInputController,
      ) async {
    final email = emailInputController.text;
    final password = passwordInputController.text;

    final scaffoldContext = context; // Capture the context here

    try {
      final registrationResult = await createRegisterRequest(email, password);
      if (registrationResult.success) {
        if(context.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
            content: Text(registrationResult.message),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ));
          const storage = FlutterSecureStorage();
          await storage.write(key: 'jwt', value: registrationResult.token);

          tryToAuth(context, registrationResult.token).then((UserAuthDataModel res) {
            context.read<User>().update(res);
            if (res.teamId == null) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const CreateTeamWidget()));
            } else {
              if (getProfile(context) is Profile) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Homepage()));
              } else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const NoProfileWidget()));
              }
            }
          });

          //Navigator.of(scaffoldContext).push(MaterialPageRoute(builder: (context) => const Homepage()));
        }
      } else {
        if(context.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
            content: Text(registrationResult.error),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      if(context.mounted) {
        print(e);
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
          content: Text('An error occurred: $e'),
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }

}