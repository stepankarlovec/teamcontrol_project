import 'dart:async';
import 'package:app/app/homepage/homepage.dart';
import 'package:app/app/noTeam/createTeam/create_team_widget.dart';
import 'package:app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../providers/provider_user.dart';
import 'package:provider/provider.dart';
import 'loading_service.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  bool cantLogin = false;

  Future<String?> getKey() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'jwt');
    return value;
  }

  void Verificate() {
    try {
      getKey().then((value) => {
            if (value != null)
              {
                print("inside try to auth"),
                tryToAuth(context, value).then((UserAuthDataModel res) {
                  print("try to auth THEN");
                  context.read<User>().update(res);
                  if (res.teamId == null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreateTeamWidget()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Homepage()));
                  }
                }).catchError((e) {
                  setState(() {
                    cantLogin = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$e'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ));
                })
              }
            else
              {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()))
              }
          });
    } catch (e) {

      print("fucc up");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ));
      setState((){
        cantLogin = true;
      });

    }
  }

  /*
  @override
  void initState() {
    print("init state..");
    Verificate();
  }

   */

  Widget cannotLogin() {
    if (cantLogin) {
      return ElevatedButton(onPressed: () {
        Verificate();
      }, child: const Text("Try again."), );
    } else {
      return const SizedBox(width: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    Verificate();

    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          cannotLogin(),
        ],
      )),
    );
  }
}

bool validateJWT(String jwt) {
  return false; // Replace with your actual validation logic
}
