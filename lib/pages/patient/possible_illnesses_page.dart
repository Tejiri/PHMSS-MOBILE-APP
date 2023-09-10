import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/patient_providers/possible_illnesses_checker_provider.dart';
import 'package:phmss_patient_app/models/possible_illness.dart';
import 'package:provider/provider.dart';

class PossibleIllnessesPage extends StatefulWidget {
  const PossibleIllnessesPage({super.key});

  @override
  State<PossibleIllnessesPage> createState() => _PossibleIllnessesPageState();
}

class _PossibleIllnessesPageState extends State<PossibleIllnessesPage> {
  @override
  Widget build(BuildContext context) {
    List<PossibleIllness> possibleIllnesses =
        Provider.of<PossibleIllnessesProvider>(context, listen: false)
            .possibleIllnesses;

    return Scaffold(
      appBar: AppBar(title: Text("Possible illnesses")),
      body: ListView.builder(
        itemCount: possibleIllnesses.length,
        itemBuilder: (context, index) {
          PossibleIllness possibleIllness = possibleIllnesses[index];
          return GestureDetector(
            onTap: () async {
              showPossibleIllnessBottomSheet(possibleIllness, context);
              
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
                    possibleIllness.name.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Divider(color: Colors.black, height: 10),
                  Text(possibleIllness.description.toString())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  showPossibleIllnessBottomSheet(PossibleIllness possibleIllness, context) {
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
                          "${possibleIllness.name}",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),

                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Text(
                          "${possibleIllness.description}",
                          style: TextStyle(
                              fontSize: 15,),
                        ),
                        //   Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child:
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Symptoms",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: possibleIllness.symptoms?.length,
                            itemBuilder: (context, index) {
                              Symptoms symptoms =
                                  possibleIllness.symptoms![index];
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('•  ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: Text(
                                        symptoms.name.toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
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


}
