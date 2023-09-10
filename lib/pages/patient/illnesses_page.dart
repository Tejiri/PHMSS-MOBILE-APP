import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_illnesses_provider.dart';
import 'package:phmss_patient_app/api/Api.dart';
import 'package:phmss_patient_app/models/illness.dart';
import 'package:phmss_patient_app/pages/patient/medications_page.dart';
import 'package:provider/provider.dart';

class IllnessesPage extends StatefulWidget {
  const IllnessesPage({super.key});

  @override
  State<IllnessesPage> createState() => _IllnessesPageState();
}

class _IllnessesPageState extends State<IllnessesPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    List<Illness> illnesses =
        Provider.of<PatientIllnessProvider>(context).illnesses;
    return Scaffold(
      appBar: AppBar(title: Text("Conditions")),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: illnesses.length,
            itemBuilder: (context, index) {
              Illness illness = illnesses[index];

              return GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Api()
                      .getMedications(
                          context: context, illnessId: illness.id ?? 0)
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicationsPage(),
                        ));
                  });
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        illness.name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Divider(color: Colors.black, height: 10),
                      Text(illness.description.toString())
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
    );
  }
}
