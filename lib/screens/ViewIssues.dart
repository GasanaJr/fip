// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infra/screens/AdminDetailsScreen.dart';
import 'package:infra/screens/DetailsScreen.dart';
import 'package:infra/services/auth_service.dart';
import 'package:provider/provider.dart';

class ViewIssues extends StatelessWidget {
  const ViewIssues({super.key});

  @override
  Widget build(BuildContext context) {
    var isAdmin = false;
    final user = Provider.of<AuthService>(context).user;
    if (user?.email == 'gasanajr08@gmail.com') {
      isAdmin = true;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text(
            "Reported Issues",
            style: TextStyle(fontSize: 26),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('issues').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final issues = snapshot.data!.docs;

              if (issues.isEmpty) {
                return Center(child: Text('No issues found.'));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xFF143342)),
                    columns: [
                      DataColumn(
                        label: Text('Location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white)),
                      ),
                      DataColumn(
                          label: Text('Status',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white))),
                      DataColumn(
                          label: Text('Actions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white))),
                    ],
                    rows: issues.map((issue) {
                      var data = issue.data() as Map<String, dynamic>;
                      var id = issue.id;

                      // Provide default values for missing data fields
                      data['location'] = data['location'] ?? 'Unknown location';
                      data['progress'] = data['progress'] ?? 'Not Started';
                      data['description'] =
                          data['description'] ?? 'No description';
                      data['levelOfDamage'] =
                          data['levelOfDamage'] ?? 'Unknown';
                      data['imageUrl'] = data['imageUrl'] ?? '';

                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return issues.indexOf(issue) % 2 == 0
                                ? Colors.blue[50]
                                : Colors.grey[200];
                          },
                        ),
                        cells: [
                          DataCell(Text(
                            data['location'],
                            style: TextStyle(fontSize: 18),
                          )),
                          DataCell(Text(
                            data['progress'],
                            style: TextStyle(
                                color: data['progress'] == 'Completed'
                                    ? Colors.green
                                    : Color.fromARGB(255, 163, 128, 24),
                                fontSize: 18),
                          )),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => isAdmin
                                          ? AdminDetailsScreen(
                                              issueName: data['description'],
                                              location: data['location'],
                                              levelOfDamage:
                                                  data['levelOfDamage'],
                                              progress: data['progress'],
                                              imageUrl: data['imageUrl'],
                                              description: data['description'],
                                              id: id,
                                            )
                                          : DetailsScreen(
                                              issueName: data['description'],
                                              location: data['location'],
                                              levelOfDamage:
                                                  data['levelOfDamage'],
                                              progress: data['progress'],
                                              imageUrl: data['imageUrl'],
                                              description: data['description'],
                                            ),
                                    ),
                                  );
                                },
                              ),
                              if (isAdmin)
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    bool? confirmDelete = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Confirm Deletion'),
                                        content: Text(
                                            'Are you sure you want to delete this issue?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmDelete == true) {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('issues')
                                            .doc(id)
                                            .delete();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Issue deleted successfully")),
                                        );
                                      } catch (e) {
                                        print("Error: $e");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Failed to delete issue")),
                                        );
                                      }
                                    }
                                  },
                                ),
                            ],
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
