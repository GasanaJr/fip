import 'package:infra/main.dart';
import 'package:infra/screens/Login.dart';
import 'package:infra/screens/Register.dart';


var routes = {
  '/home': (context) => HomeScreen(),
  '/login': (context) => AuthScreen(),
  '/report': (context) => ReportScreen(),
  '/register': (context) => RegisterScreen(),
};