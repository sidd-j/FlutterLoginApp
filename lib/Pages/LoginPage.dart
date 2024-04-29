import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/Pages/RegisterPage.dart';
import 'package:loginapp/Pages/welcome.dart';
import 'package:loginapp/ResuableWidgets/ResuableWidgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  Color fieldColor = Color.fromARGB(255, 1, 1, 1).withOpacity(0.4);
  Color bttnColor = Color.fromARGB(255, 235, 235, 235);
  Color bttnColor2 = Color.fromARGB(0, 254, 254, 254);
  Color textColor = Color.fromARGB(255, 0, 0, 0);
  Color textColor2 = Color.fromARGB(255, 255, 254, 254);

  void LoginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      // Navigate to the next screen (e.g., HomeScreen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    } on FirebaseAuthException catch (e) {
      InvalidCredentials("Invalid Credenttails");
    }
  }

  void InvalidCredentials(String errorText) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(errorText),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/Images/background.jpg"),
                  fit: BoxFit.cover)),
          child: Container(
              color: Color.fromARGB(133, 0, 0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.3, 20, 20),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField("Enter Username", Icons.person_outline,
                        false, _emailTextController, fieldColor),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField("Enter Password", Icons.lock_outline, true,
                        _passwordTextController, fieldColor),
                    const SizedBox(
                      height: 30,
                    ),
                    SigninButton(context, true, () {
                      LoginUser();
                    }, "Login", bttnColor, textColor),
                    const SizedBox(
                      height: 30,
                    ),
                    SigninButton(context, true, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    }, "Dont have a Account create one?", bttnColor2,
                        textColor2)
                  ],
                ),
              ))),
    ));
  }
}