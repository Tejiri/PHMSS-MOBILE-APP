import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/symptoms_provider.dart';
import 'package:phmss_patient_app/api/Api.dart';
import 'package:phmss_patient_app/models/symptom.dart';
import 'package:phmss_patient_app/pages/patient/possible_illnesses_page.dart';
import 'package:provider/provider.dart';

class CheckSymptomPage extends StatefulWidget {
  const CheckSymptomPage({super.key});

  @override
  State<CheckSymptomPage> createState() => _CheckSymptomPageState();
}

class _CheckSymptomPageState extends State<CheckSymptomPage> {
  List<int> selectedSymptoms = [];
  bool isLoading = false;
  // final items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"];
  @override
  Widget build(BuildContext context) {
    List<Symptom> symptoms =
        Provider.of<SymptomsProvider>(context, listen: false).symptoms;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Select Symptom")),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children: List<Widget>.generate(
                        symptoms.length,
                        (int index) {
                          Symptom symptom = symptoms[index];
                          return ChoiceChip(
                            selectedColor: Colors.lightBlue,
                            label: Text(symptom.name.toString()),
                            selected: selectedSymptoms.contains(index),
                            onSelected: (isSelected) {
                              setState(() {
                                isSelected
                                    ? selectedSymptoms.add(index)
                                    : selectedSymptoms.remove(index);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            List<String> symptomsToCheck = [];
            for (var i = 0; i < selectedSymptoms.length; i++) {
              symptomsToCheck.add(
                  Provider.of<SymptomsProvider>(context, listen: false)
                      .symptoms[selectedSymptoms[i]]
                      .name
                      .toString());
            }

            await Api()
                .checkSymptoms(
                    context: context, symptomsToCheck: symptomsToCheck)
                .then((value) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PossibleIllnessesPage(),
                  ));
            });
          },
        ),
      ),
    );
  }
}
