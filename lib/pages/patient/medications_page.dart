import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_medications_provider.dart';
import 'package:phmss_patient_app/models/medication.dart';
import 'package:provider/provider.dart';

class MedicationsPage extends StatefulWidget {
  const MedicationsPage({super.key});

  @override
  State<MedicationsPage> createState() => _MedicationsPageState();
}

class _MedicationsPageState extends State<MedicationsPage> {
  @override
  Widget build(BuildContext context) {
    List<Medication> medications =
        Provider.of<PatientMedicationProvider>(context, listen: false)
            .medications;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          Medication medication = medications[index];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  // isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
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
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Image.asset(
                                "assets/images/placeholder.jpg",
                                height: 200,
                                width: double.infinity,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [ Text("${medication.name}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            Text("Dosage - ${medication.dosage}"),
                            Text("Frequency - ${medication.frequency}"),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("${medication.description}"),
                            ),],
                              ),
                            )
                          ],
                        )),
                      ),
                    );
                  });
            },
            child: Column(
              children: [Text("${medication.name}")],
            ),
          );
        },
      ),
    );
  }
}
