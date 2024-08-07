// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infra/auth/login_or_register.dart';
import 'package:infra/firebase_options.dart';
import 'package:infra/helper/auth.dart';
import 'package:infra/models/ReportedIssuesModel.dart';
import 'package:infra/models/SurveysModel.dart';
import 'package:infra/routes/routes.dart';
import 'package:infra/screens/HomeScreen.dart';
import 'package:infra/screens/ReportScreen.dart';
import 'package:infra/screens/ProfileScreens.dart';
import 'package:infra/services/auth_service.dart';
import 'package:provider/provider.dart';

// The entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

// The main widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide ReportedIssuesModel
        ChangeNotifierProvider(
          create: (_) => ReportedIssuesModel(),
        ),
        // Provide SurveysModel
        ChangeNotifierProvider(
          create: (_) => SurveysModel(),
        ),
        // Provide AuthService
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        home: AuthPage(), // Home screen, depending on authentication status
        routes: routes, // Define application routes
      ),
    );
  }
}

// Home screen widget with navigation and logout functionality
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Current selected tab index

  // Logout user and navigate to login screen
  void logOutUser() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginOrRegister()));
  }

  // List of widgets to display in the body based on the selected index
  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ReportScreen(),
    ProfileScreens(),
  ];

  // Handle bottom navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Color(0xFF143342),
          title: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "FIP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              )
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 16), // Space between icons
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    logOutUser();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF143342),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Report'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Screen to display reported issues
class IssuesScreen extends StatelessWidget {
  IssuesScreen({super.key});
  final List<String> issues = [
    'Pothole on Main St',
    'Broken Streetlight',
    'Graffiti on Wall',
    'Missing Stop Sign',
    'Faulty CCTV Camera'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Issues'),
      ),
      body: ListView.builder(
        itemCount: issues.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(issues[index]),
            trailing: Icon(Icons.check_circle),
          );
        },
      ),
    );
  }
}

// Profile screen with user information
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isUpdated = true; // Track if profile is updated or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display user profile picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('profile_picture.avif'), // Profile picture path
              ),
              SizedBox(height: 16),
              // Display or edit first name
              _isUpdated
                  ? Text(
                      'First Name: ${_firstNameController.text}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
              SizedBox(height: 16),
              // Display or edit last name
              _isUpdated
                  ? Text(
                      'Last Name: ${_lastNameController.text}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
              SizedBox(height: 16),
              // Display or edit location
              _isUpdated
                  ? Text(
                      'Location: ${_locationController.text}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
              SizedBox(height: 16),
              // Button to toggle between edit and update mode
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isUpdated = !_isUpdated;
                  });
                },
                child: Text(_isUpdated ? 'Edit' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
