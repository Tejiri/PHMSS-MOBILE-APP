import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/patient_doctor.dart';

class PatientDoctorProvider extends ChangeNotifier {
  PatientDoctor? patientDoctor;

  void setDoctor(PatientDoctor doctor) {
    patientDoctor = doctor;
    notifyListeners();
  }

  // Method to update user from JSON object
  void updateDoctorFromJson(Map<String, dynamic> json) {
    patientDoctor = PatientDoctor.fromJson(json);
    notifyListeners();
  }
}
