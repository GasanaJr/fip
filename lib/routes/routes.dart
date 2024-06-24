import 'package:infra/main.dart';
import 'package:infra/screens/Login.dart';
import 'package:infra/screens/Register.dart';
import 'package:infra/screens/ReportScreen.dart';
import 'package:infra/screens/OnboardingOne.dart';
import 'package:infra/screens/ViewIssues.dart';

var routes = {
  '/home': (context) => HomeScreen(),
  '/login': (context) => AuthScreen(),
  '/report': (context) => ReportScreen(),
  '/register': (context) => RegisterScreen(),
  '/onboard': (context) => OnBoardingOne(),
  '/issues': (context) => ViewIssues(),
};
