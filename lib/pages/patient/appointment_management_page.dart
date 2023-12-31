import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/appointments_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_doctor_provider.dart';
import 'package:phmss_patient_app/Providers/user_provider.dart';
import 'package:phmss_patient_app/api/api.dart';
import 'package:phmss_patient_app/controllers/random.dart';
import 'package:phmss_patient_app/models/appointment.dart';
import 'package:phmss_patient_app/models/patient_doctor.dart';
import 'package:phmss_patient_app/models/user.dart';
import 'package:phmss_patient_app/pages/patient/create_appointment_page.dart';
import 'package:provider/provider.dart';

class AppointmentManagementPage extends StatefulWidget {
  const AppointmentManagementPage({super.key});

  @override
  State<AppointmentManagementPage> createState() =>
      _AppointmentManagementPageState();
}

class _AppointmentManagementPageState extends State<AppointmentManagementPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getPendingAppointments();
    super.initState();
  }

  getPendingAppointments() async {
    await Api().getPendingAppointments(context: context);
  }

  var apiKey = "api_key=5fd2ac39-15d3-4935-a36a-509597984923";
  List<String> statementToDisplay = [];
  bool isLoading = false;
  String appointmentTypeSelected = "Pending Appointments";
  var appointmentTypes = [
    "Pending Appointments",
    "Completed Appointments",
  ];

  TextEditingController appointmentDetails = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    List<Appointment> appointments =
        Provider.of<AppointmentsProvider>(context, listen: false).appointments;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(38, 48, 75, 1),
        title: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Color.fromRGBO(38, 48, 75, 1),
            ),
            child: new DropdownButton<String>(
              autofocus: false,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
              underline: DropdownButtonHideUnderline(
                child: new Container(),
              ),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
              hint: Text(
                "Select appointment type",
                style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              items: appointmentTypes.map((String dropitem) {
                return DropdownMenuItem<String>(
                    value: dropitem,
                    child: Text(
                      dropitem,
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                      ),
                    ));
              }).toList(),
              onChanged: (newitem) {
                if (this.mounted) {
                  setState(() {
                    isLoading = true;
                    this.appointmentTypeSelected = newitem!;
                  });
                }

                updateAppointmentList();
              },
              value: appointmentTypeSelected,
            )),
      ),
      body: Stack(
        children: [
          appointments.length == 0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Text("No Appointments to display",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center),
                )
              : ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    Appointment appointment = appointments[index];
                    return GestureDetector(
                      onLongPress: () {
                        user?.role == "doctor"
                            ? showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Confirm Update'),
                                    content: Text(
                                        'Are you sure you want to update this appointment to completed?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    Text('Appointment details'),
                                                content: TextField(
                                                    controller:
                                                        appointmentDetails),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      await Api()
                                                          .updateAppointment(
                                                              context: scaffoldKey
                                                                  .currentContext!,
                                                              appointmentDetails:
                                                                  appointmentDetails
                                                                      .text,
                                                              appointmentId:
                                                                  appointment
                                                                      .id)
                                                          .then((value) async {
                                                        await Api()
                                                            .getPendingAppointments(
                                                                context:
                                                                    scaffoldKey.currentContext!)
                                                            .then(
                                                          (value) {
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                          },
                                                        );

                                                        // await Api()
                                                        //     .getPendingAppointments(
                                                        //         context: context)
                                                        //     .then((value) {

                                                        // });
                                                      });
                                                    },
                                                    child: Text(
                                                      'Update',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Container();
                      },
                      onTap: () async {
                        showAppointmentBottomSheet(appointment, context);
                        // showPossibleIllnessBottomSheet(possibleIllness, context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.reason.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Divider(color: Colors.black, height: 10),
                            Text(formatTime(time: appointment.startTime)
                                    .toString() +
                                " - " +
                                formatTime(time: appointment.endTime)
                                    .toString())
                          ],
                        ),
                      ),
                    );
                  },
                ),
          isLoading == true
              ? Container(
                  decoration:
                      BoxDecoration(color: Colors.grey[400]?.withOpacity(0.6)),
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
      floatingActionButton: user?.role == "patient"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAppointmentPage(),
                    ));
              },
              child: Icon(Icons.add))
          : Container(),
    );
  }

  showAppointmentBottomSheet(Appointment appointment, context) {
    PatientDoctor? doctor =
        Provider.of<PatientDoctorProvider>(context, listen: false)
            .patientDoctor;
    return showModalBottomSheet(

        // isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return SafeArea(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),

              // height: 200,/
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20),
                  //   child: Image.asset(
                  //     "assets/images/placeholder.jpg",
                  //     height: 200,
                  //     width: double.infinity,
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${appointment.reason}",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),

                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        appointment.appointmentDetails == null
                            ? Container()
                            : Text(
                                "${appointment.appointmentDetails}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),

                        // Text(
                        //   "${appointment.}",
                        //   style: TextStyle(
                        //       fontSize: 15,),
                        // ),
                        //   Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child:
                        // ),
                        Text(
                          "Appointment time - ${formatTime(time: appointment.startTime).toString()} - ${formatTime(time: appointment.endTime).toString()}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Date - ${formatDate(date: appointment.date)}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        doctor == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Doctor",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        doctor == null
                            ? Container()
                            : Text(
                                "${doctor?.firstName} ${doctor?.middleName} ${doctor?.lastName}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),

                        appointment.appointmentDetails == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Appointment Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        appointment.appointmentDetails == null
                            ? Container()
                            : Text(
                                "${appointment.appointmentDetails}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     itemCount: possibleIllness.symptoms?.length,
                        //     itemBuilder: (context, index) {
                        //       Symptoms symptoms =
                        //           possibleIllness.symptoms![index];
                        //       return Padding(
                        //         padding: const EdgeInsets.all(5),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text('•  ',
                        //                 style: TextStyle(
                        //                     fontSize: 20,
                        //                     fontWeight: FontWeight.bold)),
                        //             Expanded(
                        //               child: Text(
                        //                 symptoms.name.toString(),
                        //                 style: TextStyle(fontSize: 18),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     }),
                        // Text("Frequency - ${possibleIllness..frequency}"),
                      ],
                    ),
                  )
                ],
              )),
            ),
          );
        });
  }

  updateAppointmentList() async {
    if (appointmentTypeSelected == "Pending Appointments") {
      await Api().getPendingAppointments(context: context).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      await Api().getCompletedAppointments(context: context).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }
}
