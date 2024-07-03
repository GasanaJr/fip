import 'package:infra/auth/login_or_register.dart';
import 'package:infra/main.dart';
import 'package:infra/screens/Login.dart';
import 'package:infra/screens/Register.dart';
import 'package:infra/screens/ReportScreen.dart';
import 'package:infra/screens/OnboardingOne.dart';
import 'package:infra/screens/ViewIssues.dart';
import 'package:infra/screens/SurveyScreen.dart';

var routes = {
  '/home': (context) => HomeScreen(),
  '/report': (context) => ReportScreen(),
  '/register': (context) => LoginOrRegister(),
  '/onboard': (context) => OnBoardingOne(),
  '/issues': (context) => ViewIssues(),
  '/survey': (context) => SurveyScreen(),
};
