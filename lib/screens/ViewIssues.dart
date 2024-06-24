// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:infra/models/ReportedIssuesModel.dart';
import 'package:provider/provider.dart';

class ViewIssues extends StatelessWidget {
  const ViewIssues({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add back button functionality here
          },
        ),
        title: Text('Reported Issues'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Add menu button functionality here
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ReportedIssuesModel>(
            builder: (context, model, child) {
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
                          label: Text('Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white))),
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
                    rows: [
                      for (int i = 0; i < model.reportedItems.length; i++)
                        DataRow(
                          color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return i % 2 == 0
                                  ? Colors.blue[50]
                                  : Colors.grey[200];
                            },
                          ),
                          cells: [
                            DataCell(Text(
                              model.reportedItems[i][0],
                              style: TextStyle(fontSize: 18),
                            )),
                            DataCell(Text(
                              model.reportedItems[i][1],
                              style: TextStyle(fontSize: 18),
                            )),
                            DataCell(Text(model.reportedItems[i][2],
                                style: TextStyle(
                                    color:
                                        model.reportedItems[i][2] == 'Completed'
                                            ? Colors.green
                                            : Colors.amber,
                                    fontSize: 18))),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.visibility),
                                  onPressed: () {
                                    // Add view functionality here
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    model.removeIssue(i);
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                    ],
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
