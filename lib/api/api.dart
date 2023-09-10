import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phmss_patient_app/Providers/appointments_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_doctor_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_illnesses_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_medications_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/possible_illnesses_checker_provider.dart';
import 'package:phmss_patient_app/Providers/symptoms_provider.dart';
import 'package:phmss_patient_app/Providers/user_provider.dart';
import 'package:phmss_patient_app/models/appointment.dart';
import 'package:phmss_patient_app/models/illness.dart';
import 'package:phmss_patient_app/models/medication.dart';
import 'package:phmss_patient_app/models/possible_illness.dart';
import 'package:phmss_patient_app/models/symptom.dart';
import 'package:phmss_patient_app/models/user.dart';
import 'package:phmss_patient_app/pages/patient/patient_homepage.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Api {
  var baseUrl = "phmss-496192cf6fa8.herokuapp.com";
  var baseExtension = "/api/v1";

  Future<void> login(
      {required context,
      required String email,
      required String password}) async {
    var url = Uri.https(baseUrl, "${baseExtension}/authentication/login");
    var requestBody = {'email': email, 'password': password};
    var response = await http.post(url,
        headers: {"Accept": "application/json"}, body: requestBody);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final Map<String, dynamic> parsedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      userProvider.updateUserFromJson(parsedJson['user']);

      if (parsedJson['user']['role'] == 'doctor') {
      } else if (parsedJson['user']['role'] == 'patient') {
         Provider.of<PatientDoctorProvider>(context, listen: false)
          .updateDoctorFromJson(parsedJson['user']['doctor']);
        print(parsedJson['user']);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PatientHomePage(),
        ));
      }
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: parsedJson['message'])
          .show();
    }
  }

  Future<void> getPatientIllnesses({required context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    var url = Uri.https(baseUrl, "${baseExtension}/patients/illnesses");
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${user?.token}"
    });
    final Map<String, dynamic> parsedJson = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Illness> illnesses = [];
      for (var element in parsedJson['illnesses']) {
        Illness illness = Illness.fromJson(element);
        illnesses.add(illness);
      }
      Provider.of<PatientIllnessProvider>(context, listen: false)
          .setIllnesses(illnesses);
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: parsedJson['message'])
          .show();
    }
  }

  Future<void> getMedications(
      {required context, required int illnessId}) async {
    final queryParameters = {'illnessId': '$illnessId'};
    var url = Uri.https(
        baseUrl, "${baseExtension}/patients/medications", queryParameters);
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer ${Provider.of<UserProvider>(context, listen: false).user?.token}"
    });

    final Map<String, dynamic> parsedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      List<Medication> medications = [];
      for (var element in parsedJson['medications']) {
        Medication medication = Medication.fromJson(element);
        medications.add(medication);
      }

      Provider.of<PatientMedicationProvider>(context, listen: false)
          .setIllnesses(medications);
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: parsedJson['message'])
          .show();
    }
  }

  Future<void> getPendingAppointments({required context}) async {
    var url = Uri.https(
      baseUrl,
      "${baseExtension}/patients/pending-appointments",
    );
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer ${Provider.of<UserProvider>(context, listen: false).user?.token}"
    });

    final Map<String, dynamic> parsedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(parsedJson);
      List<Appointment> appointments = [];
      for (var element in parsedJson['appointments']) {
        Appointment appointment = Appointment.fromJson(element);
        appointments.add(appointment);
      }
      Provider.of<AppointmentsProvider>(context, listen: false)
          .setAppointments(appointments);
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: parsedJson['message'])
          .show();
    }
  }

  Future<void> getCompletedAppointments({required context}) async {
    var url = Uri.https(
      baseUrl,
      "${baseExtension}/patients/completed-appointments",
    );
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer ${Provider.of<UserProvider>(context, listen: false).user?.token}"
    });

    final Map<String, dynamic> parsedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(parsedJson);
      List<Appointment> appointments = [];
      for (var element in parsedJson['appointments']) {
        Appointment appointment = Appointment.fromJson(element);
        appointments.add(appointment);
      }
      Provider.of<AppointmentsProvider>(context, listen: false)
          .setAppointments(appointments);
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: parsedJson['message'])
          .show();
    }
  }

  Future<void> getSymptoms({required context}) async {
    // final queryParameters = {'illnessId': '$illnessId'};
    var url = Uri.https(
      baseUrl,
      "${baseExtension}/patients/symptoms",
    );
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer ${Provider.of<UserProvider>(context, listen: false).user?.token}"
    });

    final Map<String, dynamic> parsedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(parsedJson);
      List<Symptom> symptoms = [];
      for (var element in parsedJson['symptoms']) {
        Symptom symptom = Symptom.fromJson(element);
        symptoms.add(symptom);
      }

      Provider.of<SymptomsProvider>(context, listen: false)
          .setSymptoms(symptoms);
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: parsedJson['message'])
          .show();
    }
  }

  Future<void> checkSymptoms(
      {required context, required List<String> symptomsToCheck}) async {
    print(symptomsToCheck);
    var url = Uri.https(baseUrl, "${baseExtension}/patients/check-symptoms");
    var requestBody = {'symptoms': json.encode(symptomsToCheck)};
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ${Provider.of<UserProvider>(context, listen: false).user?.token}"
        },
        body: requestBody);
    // return r

    // print(response.body.toString());
    final Map<String, dynamic> parsedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // print(parsedJson.toString());
      List<PossibleIllness> possibleIllnesses = [];
      for (var element in parsedJson['possibleIllnesses']) {
        PossibleIllness possibleIllness = PossibleIllness.fromJson(element);
        possibleIllnesses.add(possibleIllness);
      }

      Provider.of<PossibleIllnessesProvider>(context, listen: false)
          .setPossibleIllnesses(possibleIllnesses);

      print(Provider.of<PossibleIllnessesProvider>(context, listen: false)
          .possibleIllnesses);
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: parsedJson['message'])
          .show();
    }
  }

  Future<void> createAppointment(
      {required context,
      required startTime,
      required endTime,
      required date,
      required reason}) async {
    var url =
        Uri.https(baseUrl, "${baseExtension}/patients/create-appointment");
    var requestBody = {
      "reason": reason,
      "startTime": startTime,
      "endTime": endTime,
      "date": date.toIso8601String(),
      "patientId":
          Provider.of<UserProvider>(context, listen: false).user?.id.toString()
    };

    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ${Provider.of<UserProvider>(context, listen: false).user?.token}"
        },
        body: requestBody);

    final Map<String, dynamic> parsedJson = json.decode(response.body);
    // return r

    print(parsedJson);
  }
}
