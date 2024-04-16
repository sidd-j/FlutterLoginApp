import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginapp/Pages/LoginPage.dart';
import 'package:loginapp/Pages/RegisterPage.dart';

class NavToPage extends StatefulWidget {
  @override
  State<NavToPage> createState() => _NavToPagee();
}

class _NavToPagee extends State<NavToPage> {
  bool showLoginPage = true;

  void TogglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: TogglePages);
    } else {
      return RegisterPage(onTap: TogglePages);
    }
  }
}
