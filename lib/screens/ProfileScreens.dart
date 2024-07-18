// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infra/models/ReportedIssuesModel.dart';
import 'package:infra/screens/EditProfile.dart';
import 'package:infra/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    var isAdmin = false;
    final user = Provider.of<AuthService>(context).user;
    final issuesModel = Provider.of<ReportedIssuesModel>(context);

    if (user?.email == 'gasanajr08@gmail.com') {
      isAdmin = true;
    }

    if (isAdmin && !issuesModel.isCountsFetched) {
      issuesModel.fetchIssueCounts();
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Image.asset('assets/Male User.png'),
                Text(
                  user?.displayName ?? "User",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Kigali - Rwanda",
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                ),
                SizedBox(height: 30),
                isAdmin
                    ? FutureBuilder(
                        future: issuesModel.fetchIssueCounts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error fetching data');
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IssueCountCard(
                                  count: issuesModel.completedCount,
                                  label: "Completed",
                                ),
                                IssueCountCard(
                                  count: issuesModel.progressCount,
                                  label: "Progress",
                                ),
                                IssueCountCard(
                                  count: issuesModel.notStartedCount,
                                  label: "Not Started",
                                ),
                              ],
                            );
                          }
                        },
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 130,
                        height: 100,
                        child: Column(
                          children: [],
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Divider(
              color: Colors.black,
              thickness: 0,
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 30),
                      SizedBox(width: 5),
                      Text(
                        "Edit Profile",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 30),
                      SizedBox(width: 5),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IssueCountCard extends StatelessWidget {
  final int count;
  final String label;

  const IssueCountCard({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      width: 130,
      height: 100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              count.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
