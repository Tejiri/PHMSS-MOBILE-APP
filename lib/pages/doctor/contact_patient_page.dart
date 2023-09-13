import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/doctor_providers/doctor_patients_provider.dart';
import 'package:phmss_patient_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPatientPage extends StatefulWidget {
  const ContactPatientPage({super.key});

  @override
  State<ContactPatientPage> createState() => _ContactPatientPageState();
}

class _ContactPatientPageState extends State<ContactPatientPage> {
  @override
  Widget build(BuildContext context) {
    List<User> patients =
        Provider.of<DoctorPatientsProvider>(context, listen: false).patients;
    return Scaffold(
      appBar: AppBar(title: Text("Contact Patient")),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          User patient = patients[index];
          return Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 0.5))),
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(children: [
                    Container(
                      child: CircleAvatar(),
                      height: 30,
                      padding: EdgeInsets.only(right: 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${patient.firstName} ${patient.lastName}",
                          // style: GoogleFonts.merriweather(
                          //     fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "${patient.phoneNumber}",
                          // style: GoogleFonts.merriweather(
                          //     textStyle: TextStyle(
                          //         color: Color.fromRGBO(38, 48, 75, 1),
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 12)),
                        ),
                      ],
                    )
                  ]),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          launchDialer(patient.phoneNumber.toString());
                        },
                        child: Icon(
                          Icons.phone,
                          color: Color.fromRGBO(38, 48, 75, 1),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 30)),
                      GestureDetector(
                        onTap: () async {
                          launchSms(patient.phoneNumber.toString());
                        },
                        child: Icon(
                          Icons.sms,
                          color: Color.fromRGBO(38, 48, 75, 1),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void launchDialer(String phoneNumber) async {
    String dialerUrl = "tel:$phoneNumber";

    if (await canLaunch(dialerUrl)) {
      await launch(dialerUrl);
    } else {
      throw "Could not launch $dialerUrl";
    }
  }

  void launchSms(String phoneNumber) async {
    String smsUrl = "sms:$phoneNumber";

    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
    } else {
      throw "Could not launch $smsUrl";
    }
  }
}
