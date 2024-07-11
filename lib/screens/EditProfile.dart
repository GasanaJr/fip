// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infra/helper/helpers.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final bool isAdmin = false;
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch current user details
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      fullNameController.text = user.displayName ?? "";
      emailController.text = user.email ?? "";
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  void updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updateDisplayName(fullNameController.text);
          await user.updateEmail(emailController.text);
          displayMessageToUser("User update successfully", context);
        }

        if (passwordController.text.isNotEmpty &&
            passwordConfirmController.text == passwordController.text) {
          await user?.updatePassword(passwordController.text);
        }
      } on FirebaseAuthException catch (e) {
        displayMessageToUser("An error occured $e", context);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text(
            "Update Profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 11, 28, 37),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              // Icon and names and location
              SizedBox(
                height: 40,
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/Male User.png'),
                    Text(
                      fullNameController.text,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kigali -  Rwanda",
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 0,
                ),
              ),

              // Change Form
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                      controller: passwordController,
                      obscureText: true,
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
                      controller: passwordConfirmController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                updateUserProfile();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color(0xFF143342)),
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                textStyle: MaterialStatePropertyAll<TextStyle>(
                                    TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                minimumSize: MaterialStatePropertyAll<Size>(
                                    Size(150, 50)),
                              ),
                              child: Text("Update"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
