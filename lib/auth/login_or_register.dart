// ignore_for_file: prefer_const_constructors
//this directive tells the dart analyzer to ignore the 'prefer_const_constructors'

import 'package:flutter/material.dart';
import 'package:infra/screens/Login.dart';
import 'package:infra/screens/Register.dart';

//This is the main widget that toogles between the login and register screens
class LoginOrRegister extends StatefulWidget {

  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build method returns either the login or register screen based on the showLoginPage flag
    if (showLoginPage) {
      //show login page with callback to tooglepages method
      return AuthScreen(onTap: togglePages);
    } else {
      //show register page with a callback to tooglepages method
      return RegisterScreen(onTap: togglePages);
    }
  }
}
