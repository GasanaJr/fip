// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

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
                      onChanged: (String? newValue) {},
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
                      onChanged: (String? newValue) {},
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
                      onChanged: (String? newValue) {},
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
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {},
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
