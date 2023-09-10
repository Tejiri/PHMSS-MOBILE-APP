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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                            start =
                                formatTimeOfDay(time);
                          });
                        },
                        is24HrFormat: false,
                      ),
                    );
                  },
                  child: Text(
                    "Start time - $start",
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
                    "End time - $end",
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
                      ? 'No date selected'
                      : '${_selectedDate!.toLocal()}'.split(' ')[0],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: appointmentReason,
                ),
              ),

              ElevatedButton(onPressed: () async {
               await Api().createAppointment(context: context, startTime: start, endTime: end, date: _selectedDate, reason: "test");
              }, child: Text("Create Appointment")),
              // ElevatedButton(
              //   onPressed: () => ,
              //   child: Text('Select date'),
              // ),
            ]),
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
