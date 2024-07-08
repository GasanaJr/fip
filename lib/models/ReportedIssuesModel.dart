import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportedIssuesModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _reportedIssues = [];

  ReportedIssuesModel() {
    _fetchReportedIssues();
  }

  Future<void> _fetchReportedIssues() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('issues').get();
    _reportedIssues.clear();
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      data['id'] = doc.id;  // Include the document ID
      data['location'] = data['location'] ?? 'Unknown location';
      data['levelOfDamage'] = data['levelOfDamage'] ?? 'Unknown';
      data['description'] = data['description'] ?? 'No description';
      data['priority'] = data['priority'] ?? 'Unknown';
      data['progress'] = data['progress'] ?? 'Unknown'; // Assuming 'progress' field
      data['imageUrl'] = data['imageUrl'] ?? '';
      _reportedIssues.add(data);
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> get reportedItems => _reportedIssues;

  void removeIssue(int index) {
    _reportedIssues.removeAt(index);
    notifyListeners();
  }
}
