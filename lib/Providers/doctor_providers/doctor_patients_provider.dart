

import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/user.dart';

class DoctorPatientsProvider extends ChangeNotifier {
  List<User> patients = [];

  void setPatients(List<User> patientsFromApi) {
    print(patientsFromApi);
    patients = patientsFromApi;
    notifyListeners();
  }
}