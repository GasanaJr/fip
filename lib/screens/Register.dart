// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unused_local_variable, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infra/helper/helpers.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;

  RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  void registerUser() async {
    // Show a loader
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // Check if passwords match
    if (passwordConfirmController.text != passwordController.text) {
      // Pop the loader
      Navigator.pop(context);

      // Show error message
      displayMessageToUser("The passwords don't match", context);
    } else {
      // Create the actual user
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
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
            "Register to FIP",
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
                gradient: LinearGradient(colors: [
              Color(0xFF143342),
              Colors.white,
            ], begin: Alignment.topRight, end: Alignment.bottomRight)),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "FIP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
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
                        horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Full Name",
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
                              labelText: "Enter your Full Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: fullNameController,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
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
                        SizedBox(
                          height: 5,
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
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          obscureText: true,
                          controller: passwordConfirmController,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    registerUser();
                                    // Navigator.pushReplacementNamed(
                                    //     context, '/login');
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Color(0xFF143342)),
                                    foregroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.white),
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                    minimumSize: MaterialStatePropertyAll<Size>(
                                        Size(150, 50)),
                                  ),
                                  child: Text("Register"),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                            ],
                          ),
                        ),
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
