// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDetailsScreen extends StatefulWidget {
  final String issueName;
  final String location;
  final String levelOfDamage;
  final String progress;
  final String imageUrl;
  final String description;
  final String id;

  const AdminDetailsScreen({
    super.key,
    required this.issueName,
    required this.location,
    required this.levelOfDamage,
    required this.progress,
    required this.imageUrl,
    required this.description,
    required this.id,
  });

  @override
  State<AdminDetailsScreen> createState() => _AdminDetailsScreenState();
}

class _AdminDetailsScreenState extends State<AdminDetailsScreen> {
  String? _newStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF143342),
          title: Text(
            "Detail",
            style: GoogleFonts.montserrat(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Color(0xFF143342),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  // Image submitted
                  Container(
                    child: Image.network(
                      widget.imageUrl,
                      height: 300,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  // Description of the issue
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(40)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(widget.issueName,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.description,
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Location: ${widget.location}",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Level of Damage: ${widget.levelOfDamage}",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Status: ${widget.progress}",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "New Status",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                labelText: "Update the status",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            items: [
                              DropdownMenuItem(
                                  value: "Not Started",
                                  child: Text("Not Started")),
                              DropdownMenuItem(
                                  value: "Progress", child: Text("Progress")),
                              DropdownMenuItem(
                                  value: "Completed", child: Text("Completed")),
                            ],
                            onChanged: (String? newValue) {
                              _newStatus = newValue;
                            },
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 20,
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                bool? confirmUpdate = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Status Update"),
                                          content: Text(
                                              "You are about to update a status"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: Text("Update"))
                                          ],
                                        ));
                                if (confirmUpdate == true) {
                                  showDialog(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      builder: (context) => const Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                  await FirebaseFirestore.instance
                                      .collection('issues')
                                      .doc(widget.id)
                                      .update({
                                    'progress': _newStatus,
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Issue reported successfully!')),
                                    );
                                  });
                                }
                                Navigator.pop(context);
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
    );
  }
}
