// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infra/screens/SurveyDetails.dart';

class ViewSurvey extends StatelessWidget {
  const ViewSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text(
            "Submitted Surveys",
            style: TextStyle(fontSize: 26),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('surveys').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final surveys = snapshot.data!.docs;

              if (surveys.isEmpty) {
                return Center(child: Text('No Surveys found.'));
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
                        label: Text('Satisfaction',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white)),
                      ),
                      DataColumn(
                          label: Text('Response Time',
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
                    rows: surveys.map((survey) {
                      var data = survey.data() as Map<String, dynamic>;
                      var id = survey.id;

                      // Provide default values for missing data fields
                      data['satisfaction'] = data['satisfaction'] ?? 'N/A';
                      data['responseTime'] = data['responseTime'] ?? 'N/A';
                      data['communityInteraction'] =
                          data['communityInteraction'] ?? 'N/A';
                      data['improvements'] = data['improvements'] ?? 'N/A';

                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return surveys.indexOf(survey) % 2 == 0
                                ? Colors.blue[50]
                                : Colors.grey[200];
                          },
                        ),
                        cells: [
                          DataCell(Text(
                            data['satisfaction'],
                            style: TextStyle(fontSize: 18),
                          )),
                          DataCell(Text(
                            data['responseTime'],
                            style: TextStyle(fontSize: 18),
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
                                      // Add abstraction to the views ensuring the admins can update
                                      builder: (context) => SurveyDetails(
                                        satisfaction: data['satisfaction'],
                                        responseTime: data['responseTime'],
                                        communityInteraction:
                                            data['communityInteraction'],
                                        improvements: data['improvements'],
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                                              Navigator.of(context).pop(false),
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
                                          .collection('surveys')
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
                                            content:
                                                Text("Failed to delete issue")),
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
