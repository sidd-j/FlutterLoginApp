import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/Pages/LoginPage.dart';
import 'package:loginapp/Pages/NavToPage.dart';
import 'package:loginapp/Pages/welcome.dart';
import "HomePage.dart";

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in

            print(snapshot.data);
            return Welcome();
          } else {
            // User is not logged in
            return NavToPage();
          }
        },
      ),
    );
  }
}
