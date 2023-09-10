import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/medication.dart';

class PatientMedicationProvider extends ChangeNotifier {
  List<Medication> medications = [];

  void setIllnesses(List<Medication> medicationsFromApi) {
    medications = medicationsFromApi;
    notifyListeners();
  }
}