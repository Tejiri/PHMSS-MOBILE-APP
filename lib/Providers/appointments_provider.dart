import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/appointment.dart';

class AppointmentsProvider extends ChangeNotifier {
  List<Appointment> appointments = [];

  void setAppointments(List<Appointment> appointmentsFromApi) {
    appointments = appointmentsFromApi;
    notifyListeners();
  }
}