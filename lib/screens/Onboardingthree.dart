// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infra/auth/login_or_register.dart';
import 'package:infra/screens/Register.dart';

class OnBoardingThree extends StatefulWidget {
  const OnBoardingThree({super.key});

  @override
  State<OnBoardingThree> createState() => _OnBoardingThreeState();
}

class _OnBoardingThreeState extends State<OnBoardingThree>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Future.delayed(
    //     Duration(seconds: 5),
    //     () => {
    //           Navigator.pushReplacement(context,
    //               MaterialPageRoute(builder: (context) => RegisterScreen()))
    //         });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;

      return GestureDetector(
        onTap: () {
          print("Hello Page 3");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginOrRegister()));
        },
        child: Column(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: screenHeight * 0.3, // 30% of screen height
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: -30,
                    child: Image.asset(
                      'assets/Ellipse 1.png',
                      // width: screenWidth * 0.8, // 80% of screen width
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.1, // Adjusted based on screen width
                    top: -40,
                    child: Image.asset(
                      'assets/Ellipse 2.png',
                      width: screenWidth * 1.1, // 80% of screen width
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Let's Get Started!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF254D6A),
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/Checkmark.png',
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Let us build the community we want",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF254D6A),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    }));
  }
}
