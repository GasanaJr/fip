// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:infra/auth/login_or_register.dart';
import 'package:infra/main.dart';
import 'package:infra/screens/SplashScreen.dart';
import 'package:infra/services/auth_service.dart';
import 'package:provider/provider.dart';

// Auth helper to listen to authstate changes
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthService>(
        builder: (context, authService, _) {
          if (authService.user != null) {
            return HomeScreen();
          } else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
