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
    if (showLoginPage) {
      return AuthScreen(onTap: togglePages);
    } else {
      return RegisterScreen(onTap: togglePages);
    }
  }
}
