import 'package:app/app/auth/forgotpassword/forgotPassword_widget.dart';
import 'package:app/app/auth/login/login_domain.dart';
import 'package:app/pages/RegisterPage.dart';
import 'package:flutter/material.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});


  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this key


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: const BoxDecoration(),
          child: Column(children: [
            Center(
                child:
                    Image.asset('assets/images/logo_colored.png', width: 260)),
            const SizedBox(
              height: 30,
            ),
            buildLogin()
          ]),
        ));
  }

  Center buildLogin() {
    return Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: TextField(
                      controller: emailInputController,
                        decoration: const InputDecoration(
                      hintText: 'Email address',
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextField(
                      controller: passwordInputController,
                      obscureText: true,
                        decoration: const InputDecoration(
                      hintText: 'Password',
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage()));
                          },
                          child: const Text('Not registered yet?')),
                      OutlinedButton(
                          onPressed: () => {
                            LoginDomain.handleLogin(context, emailInputController, passwordInputController)
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero),
                                      side:
                                          BorderSide(color: Colors.purple)))),
                          child: const Text("Login"))
                    ],
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPasswordWidget()));
                            },
                            child: const Text('Forgot your password?')),
                      ),
                    ),
                  )
                ],
              ),

            ),
          );
  }
}
