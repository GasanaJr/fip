import 'package:flutter/material.dart';

class ReportedIssuesModel extends ChangeNotifier {
  final List _reportedIssues = [
    ["Kicukiro", "Kisimenti Road Damaged", "Progress"],
    ["Gasabo", "Kimironko Road Damaged", "Completed"]
  ];

  get reportedItems => _reportedIssues;

  void removeIssue(int index) {
    _reportedIssues.removeAt(index);
    notifyListeners();
  }
}