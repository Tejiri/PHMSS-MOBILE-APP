

import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/symptom.dart';

class SymptomsProvider extends ChangeNotifier {
  List<Symptom> symptoms = [];

  void setSymptoms(List<Symptom> symptomsFromApi) {
    symptoms = symptomsFromApi;
    notifyListeners();
  }
}