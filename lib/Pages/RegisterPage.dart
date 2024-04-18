import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loginapp/Pages/LoginPage.dart';
import 'package:loginapp/Pages/welcome.dart';
import 'package:loginapp/ResuableWidgets/ResuableWidgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController =
      TextEditingController();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final Color fieldColor = Color.fromARGB(86, 255, 255, 255);
  final Color bttnColor = Color.fromARGB(255, 255, 255, 255);
  final Color bttnColor2 = Color.fromARGB(0, 254, 254, 254);
  final Color textColor = Color.fromARGB(255, 0, 0, 0);
  final Color textColor2 = Color.fromARGB(255, 255, 254, 254);

  void signUpUser() async {
    try {
      if (_passwordTextController.text == _passwordConfirmTextController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailTextController.text.trim(),
            password: _passwordTextController.text.trim());

        await addUserDetails(
            _nameTextController.text.trim(),
            int.parse(_phoneNumberController.text.trim()),
            _emailTextController.text.trim());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Welcome()),
        );
      } else {
        invalidCredentials("Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      invalidCredentials(e.code);
    }
  }

  Future<void> addUserDetails(
      String fullname, int phonenum, String email) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .add({'FullName': fullname, 'PhoneNum': phonenum, 'Email': email});
  }

  void invalidCredentials(String errorMsg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(errorMsg),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/Images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Color.fromARGB(149, 6, 6, 6),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: Color.fromARGB(255, 1, 0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).size.height * 0,
                  20,
                  20,
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Create account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 251, 251),
                        fontSize: 25,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      "Enter Full Name",
                      Icons.person_outline,
                      false,
                      _nameTextController,
                      fieldColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      "Enter your email",
                      Icons.person_outline,
                      false,
                      _emailTextController,
                      fieldColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PhoneNumberField(
                      "Enter Phone Number",
                      Icons.phone,
                      false,
                      _phoneNumberController,
                      fieldColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      "Enter Password",
                      Icons.lock_outline,
                      true,
                      _passwordTextController,
                      fieldColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      "Confirm Password",
                      Icons.lock_outline,
                      true,
                      _passwordConfirmTextController,
                      fieldColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'I accept the terms and privacy policy',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 251, 251),
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                    ),
                    SigninButton(context, false, () {
                      signUpUser();
                    }, "Sign Up", bttnColor, textColor),
                    SigninButton(context, true, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }, "Already have a Account ? log in", bttnColor2,
                        textColor2)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
