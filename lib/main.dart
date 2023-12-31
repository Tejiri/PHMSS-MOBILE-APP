import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/appointments_provider.dart';
import 'package:phmss_patient_app/Providers/doctor_providers/doctor_patients_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_doctor_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_illnesses_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_medications_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/possible_illnesses_checker_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/rating_provider.dart';
import 'package:phmss_patient_app/Providers/symptoms_provider.dart';
import 'package:phmss_patient_app/Providers/user_provider.dart';
import 'package:phmss_patient_app/pages/LoginPage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  // runApp(MyApp());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
          create: (context) => PatientIllnessProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientMedicationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PossibleIllnessesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppointmentsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SymptomsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientDoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RatingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorPatientsProvider(),
        )
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    ),
  );
}
