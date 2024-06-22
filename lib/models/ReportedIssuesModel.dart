import 'package:flutter/material.dart';

class ReportedIssuesModel extends ChangeNotifier {
  final List _reportedIssues = [
    ["Kicukiro", "Kisimenti Road Damaged"],
    ["Gasabo", "Kimironko Road Damaged"]
  ];

  get reportedItems => _reportedIssues;
}