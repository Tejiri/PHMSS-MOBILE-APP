import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/illness.dart';

class PatientIllnessProvider extends ChangeNotifier {
  List<Illness> illnesses = [];

  void setIllnesses(List<Illness> illnessesFromApi) {
    illnesses = illnessesFromApi;
    notifyListeners();
  }
}
