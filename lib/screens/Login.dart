// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infra/helper/helpers.dart';
import 'package:infra/main.dart';
import 'package:infra/services/auth_service.dart';
import 'package:infra/services/opt_service.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  final void Function()? onTap;

  const AuthScreen({super.key, required this.onTap});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool codeSent = false;
  final OtpService otpService = OtpService();

  void userLogin(BuildContext context) async {
    // Show loader
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Signin block
    try {
      await Provider.of<AuthService>(context, listen: false)
          .signIn(emailController.text, passwordController.text);

      // Send verification code to the phone number
      await otpService.requestOtp(emailController.text);

      setState(() {
        codeSent = true;
      });

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    } catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.toString(), context);
    }
  }

  void verifyCode(BuildContext context) async {
    // Show loader
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Verify OTP
    try {
      await otpService.verifyOtp(emailController.text, codeController.text);

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF143342),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          leading: Icon(
            Icons.menu,
            color: Colors.white,
            size: 35,
          ),
          title: Text(
            "Login to FIP",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 11, 28, 37),
        ),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF143342),
                  Colors.white,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                  child: Center(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 200,
                      height: 150,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "FIP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!codeSent) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Enter your Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: emailController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            obscureText: true,
                            controller: passwordController,
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                userLogin(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Color(0xFF143342),
                                ),
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                textStyle: MaterialStatePropertyAll<TextStyle>(
                                  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                minimumSize: MaterialStatePropertyAll<Size>(
                                    Size(150, 50)),
                              ),
                              child: Text("Log In"),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Click here',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = widget.onTap,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ] else ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              "Verification Code",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Enter your Verification Code",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: codeController,
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                verifyCode(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Color(0xFF143342),
                                ),
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                textStyle: MaterialStatePropertyAll<TextStyle>(
                                  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                minimumSize: MaterialStatePropertyAll<Size>(
                                    Size(150, 50)),
                              ),
                              child: Text("Verify Code"),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
