import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:phmss_patient_app/api/api.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({super.key});

  @override
  State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  Time time = Time(hour: 12, minute: 0);

  DateTime? _selectedDate;
  String start = "Start time";
  String end = "End time";
  TextEditingController appointmentReason = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Create Appointment"),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: time,
                              onChange: (p0) {
                                time = p0;
                                String formattedTime = formatTimeOfDay(time);
                                print('Formatted Time: $formattedTime');
            
                                setState(() {
                                  start = formatTimeOfDay(time);
                                });
                              },
                              is24HrFormat: false,
                            ),
                          );
                        },
                        child: Text(
                          start == "Start time"
                              ? "Tap to select appointment start time"
                              : "Start time - $start",
                          style: TextStyle(fontSize: 20),
                        )),
            
                    Padding(padding: EdgeInsets.only(top: 10)),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: time,
                              onChange: (p0) {
                                time = p0;
                                String formattedTime = formatTimeOfDay(time);
                                print('Formatted Time: $formattedTime');
            
                                setState(() {
                                  end = formatTimeOfDay(time);
                                });
                              },
                              is24HrFormat: false,
                            ),
                          );
                        },
                        child: Text(
                          end == "End time"
                              ? "Tap to select appointment end time"
                              : "End time - $end",
                          style: TextStyle(fontSize: 20),
                        )),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Text(
                        style: TextStyle(fontSize: 20),
                        _selectedDate == null
                            ? 'Tap to select appointment date'
                            : '${_selectedDate!.toLocal()}'.split(' ')[0],
                      ),
                    ),
            
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        controller: appointmentReason,
                        decoration: InputDecoration(
                            hintText: "Enter Reason for appointment"),
                      ),
                    ),
            
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await Api()
                              .createAppointment(
                                  context: context,
                                  startTime: start,
                                  endTime: end,
                                  date: _selectedDate,
                                  reason: appointmentReason.text)
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: Text("Create Appointment")),
                    // ElevatedButton(
                    //   onPressed: () => ,
                    //   child: Text('Select date'),
                    // ),
                  ]),
            ),
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
    ));
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date. Usually DateTime.now()
      firstDate: DateTime(2000), // Lower bound for the date
      lastDate: DateTime(2101), // Upper bound for the date
    );
    if (picked != null && picked != _selectedDate) {
      print(picked);
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hours = timeOfDay.hour.toString().padLeft(2, '0');
    final minutes = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
