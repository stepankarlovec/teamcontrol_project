import 'package:app/app/auth/register/register_domain.dart';
import 'package:app/pages/LoginPage.dart';
import 'package:flutter/material.dart';


class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({super.key});


  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {

  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final passwordAgainInputController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this key



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8,bottom: 8),
              child: Text("Reset your password",style: TextStyle(
                fontSize: 28
              )),
            ),
            Text("Insert email of your account and we are gonna send you link to reset your password."),
            TextField(
              controller: emailInputController,
              decoration: const InputDecoration(
                hintText: 'Email address',
              )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () => {
                    RegisterDomain.handleRegistration(context, emailInputController, passwordInputController, passwordAgainInputController)
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.zero),
                              side:
                              BorderSide(color: Colors.purple)))),
                  child: const Text("Reset password")),
            )
        ]),
      )
      );
  }
}