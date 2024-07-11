// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  String? _satisfaction;
  String? _responseTime;
  String? _communityInteraction;
  TextEditingController _improvements = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF143342),
          title: Text(
            "Survey",
            style: TextStyle(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Kindly Fill Out Our Survey",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Overall Satisfaction",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Select",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "Very Good",
                          child: Text("Very Good 🥳"),
                        ),
                        DropdownMenuItem(
                          value: "Good",
                          child: Text("Good 😌"),
                        ),
                        DropdownMenuItem(
                          value: "Fair",
                          child: Text("Fair 😀"),
                        ),
                        DropdownMenuItem(
                          value: "Bad",
                          child: Text("Bad 😣"),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _satisfaction = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Response Time",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Select",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "Quick",
                          child: Text("Quick ⚡️"),
                        ),
                        DropdownMenuItem(
                          value: "Fair",
                          child: Text("Fair 😀"),
                        ),
                        DropdownMenuItem(
                          value: "Slow",
                          child: Text("Bad 😣"),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _responseTime = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Community Interaction",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Select",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "Very Good",
                          child: Text("Very Good 🥳"),
                        ),
                        DropdownMenuItem(
                          value: "Good",
                          child: Text("Good 😌"),
                        ),
                        DropdownMenuItem(
                          value: "Fair",
                          child: Text("Fair 😀"),
                        ),
                        DropdownMenuItem(
                          value: "Bad",
                          child: Text("Bad 😣"),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _communityInteraction = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Suggest Improvements",
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
                        labelText: "Suggestions",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: _improvements,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          bool? confirmSubmission = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Confirm Submission"),
                              content: Text("You are about to submit a survey"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text("Submit"),
                                ),
                              ],
                            ),
                          );
                          if (confirmSubmission == true) {
                            showDialog(
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            await FirebaseFirestore.instance
                                .collection('surveys')
                                .add({
                              'satisfaction': _satisfaction,
                              'responseTime': _responseTime,
                              'communityInteraction': _communityInteraction,
                              'improvements': _improvements.text
                            });
                            Navigator.pop(context);

                            setState(() {
                              _communityInteraction = null;
                              _responseTime = null;
                              _satisfaction = null;
                              _improvements.clear();
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Survey Submitted Successfully"),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xFF143342)),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white),
                          textStyle: MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          minimumSize:
                              MaterialStatePropertyAll<Size>(Size(150, 50)),
                        ),
                        child: Text("Submit"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
