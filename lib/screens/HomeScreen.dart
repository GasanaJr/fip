// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infra/components/ReportedIssueTile.dart';
import 'package:infra/models/ReportedIssuesModel.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Welcome, Junior",
                style: TextStyle(fontSize: 24),
              ),
            ),
            // Let's Ensure Road safety
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Let's find a safe route for you",
                style: GoogleFonts.notoSerif(
                    fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            // Divider
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),

            SizedBox(
              height: 10,
            ),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFF143342),
                                borderRadius: BorderRadius.circular(35)),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add an Issue",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFF143342),
                                borderRadius: BorderRadius.circular(35)),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "View Issues",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFF143342),
                                borderRadius: BorderRadius.circular(35)),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.feedback,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Take Survey",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),

            // Reported Issues

            SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Reported Issues",
                style: TextStyle(fontSize: 20),
              ),
            ),

            Expanded(
              child: Consumer<ReportedIssuesModel>(
                builder: (context, value, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1.5,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.reportedItems.length,
                        padding: EdgeInsets.all(12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 0.9,
                        ),
                        itemBuilder: (context, index) {
                          return ReportedIssueTile(
                            Location: value.reportedItems[index][0],
                            Description: value.reportedItems[index][1],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
