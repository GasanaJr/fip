// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  final String issueName;
  final String location;
  final String levelOfDamage;
  final String progress;

  const DetailsScreen({
    super.key,
    required this.issueName,
    required this.location,
    required this.levelOfDamage,
    required this.progress,
  });

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
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              // Image submitted
              Container(
                child: Image.asset('assets/road1.webp'),
              ),
              SizedBox(
                height: 40,
              ),

              // Description of the issue
              Expanded(
                child: Container(
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
                      Text(issueName,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "There is a broken road at Kisimenti that has the potential cause accidents",
                        style: GoogleFonts.montserrat(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Location: $location",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Level of Damage: $levelOfDamage",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Status: $progress",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
