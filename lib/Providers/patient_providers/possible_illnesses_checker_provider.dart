import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/possible_illness.dart';

class PossibleIllnessesProvider extends ChangeNotifier {
  List<PossibleIllness> possibleIllnesses = [];

  void setPossibleIllnesses(List<PossibleIllness> possibleIllnessesFromApi) {
    possibleIllnesses = possibleIllnessesFromApi;
    notifyListeners();
  }
}
