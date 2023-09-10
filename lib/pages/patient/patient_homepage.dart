import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/user_provider.dart';
import 'package:phmss_patient_app/api/api.dart';
import 'package:phmss_patient_app/models/user.dart';
import 'package:phmss_patient_app/pages/LoginPage.dart';
import 'package:phmss_patient_app/pages/patient/appointment_management_page.dart';
import 'package:phmss_patient_app/pages/patient/check_symptom_page.dart';
import 'package:phmss_patient_app/pages/patient/illnesses_page.dart';
import 'package:phmss_patient_app/pages/patient/rate_doctor_page.dart';
import 'package:phmss_patient_app/pages/patient/update_password_page.dart';
import 'package:provider/provider.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${user?.email}"),
                  Text("${user?.address}"),
                  Text("${user?.dateOfBirth}"),
                  Text("${user?.firstName}"),
                  Text("${user?.lastName}"),
                  Text("${user?.middleName}"),
                  Text("${user?.phoneNumber}")
                ],
              ),
            ),
            // Column(
            //   children: [
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: GridView.count(
            //           crossAxisCount: 2,
            //           crossAxisSpacing:
            //               20.0, // Spacing between items in a horizontal line
            //           mainAxisSpacing:
            //               20.0, // Spacing between items in a vertical line
            //           childAspectRatio: 2 / 2, // Aspect ratio for each item
            //           children: List.generate(10, (index) {
            //             return Container(
            //               // padding: EdgeInsets.all(10),
            //               // width: MediaQuery.sizeOf(context).width,
            //               // height: MediaQuery.sizeOf(context).height,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(20),
            //                 border: Border.all(),
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey
            //                         .withOpacity(0.5), // Shadow color
            //                     spreadRadius: 5, // Spread radius
            //                     blurRadius: 7, // Blur radius
            //                     offset:
            //                         Offset(0, 3), // Changes position of shadow
            //                   ),
            //                 ],
            //               ),
            //               child: Center(
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Icon(Bootstrap.clock, size: 50),
            //                     Padding(padding: EdgeInsets.only(bottom: 5)),
            //                     //      Icon(
            //                     //   Icons.medical_information,
            //                     //   size: 50,
            //                     // ),
            //                     Text(
            //                       "Check Symptoms",
            //                       textAlign: TextAlign.center,
            //                       style: TextStyle(
            //                           fontSize: 25,
            //                           fontWeight: FontWeight.bold),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             );
            //           }),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            isLoading == true
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[400]?.withOpacity(0.6)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Loading",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                child: Center(
                    child: Text(
                  "PHMSS",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                )),
                height: 200,
                decoration: BoxDecoration(color: Colors.blue[200]),
              ),
              drawerContainer(title: "Check Medication"),
              drawerContainer(title: "Check Symptoms"),
              drawerContainer(title: "Dietary Recommendations"),
              drawerContainer(title: "Appointment management"),
              drawerContainer(title: "Rate doctor"),
              drawerContainer(title: "Update password"),
              drawerContainer(title: "Logout"),
            ],
          ),
        ),
      ),
    );
  }

  drawerContainer({required String title}) {
    return GestureDetector(
      onTap: () async {
        switch (title) {
          case "Logout":
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false);
            break;
          case "Check Symptoms":
            Navigator.pop(context);
            setState(() {
              isLoading = true;
            });

            await Api().getSymptoms(context: context).then((value) {
              setState(() {
                isLoading = false;
              });

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckSymptomPage(),
                  ));
            });

            break;
          case "Check Medication":
            Navigator.pop(context);
            setState(() {
              isLoading = true;
            });

            await Api().getPatientIllnesses(context: context).then((value) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IllnessesPage(),
                  ));
            });
            break;

          case "Appointment management":
            Navigator.pop(context);
            setState(() {
              isLoading = true;
            });

            await Api().getPendingAppointments(context: context).then((value) {
              setState(() {
                isLoading = false;
              });

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentManagementPage(),
                  ));
            });

            break;
          case "Rate doctor":
            Navigator.pop(context);
            setState(() {
              isLoading = true;
            });

            await Api().getDoctorRating(context: context).then((value) {
              setState(() {
                isLoading = false;
              });

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RateDoctorPage(),
                  ));
            });

            break;

          case "Update password":
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePasswordPage(),
                ));

            break;
          default:
        }

        // switch (expression) {
        //   case value:

        //     break;
        //   default:
        // }
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
