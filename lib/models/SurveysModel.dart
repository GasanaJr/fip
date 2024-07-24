import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SurveysModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _survey = [];

  SurveysModel() {
    _fetchSurvey();
  }

  Future<void> _fetchSurvey() async {
    print("Fetching survey data...");

    try {
      final QS = await FirebaseFirestore.instance.collection('surveys').get();
      print("Query successful. Documents fetched: ${QS.docs.length}");
      _survey.clear();

      for (var doc in QS.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        data['satisfaction'] = doc['satisfaction'] ?? 'N/A';
        data['responseTime'] = doc['responseTime'] ?? 'N/A';
        data['communityInteraction'] = doc['communityInteraction'] ?? 'N/A';
        data['improvements'] = doc['improvements'] ?? 'N/A';
        _survey.add(data);
        print("Document added: $data");
      }

      notifyListeners(); // Notify listeners after data is fetched
      print("Survey data fetching complete.");
    } catch (e) {
      print("Error fetching survey data: $e");
    }
  }

  List<Map<String, dynamic>> get Surveys => _survey;
}
