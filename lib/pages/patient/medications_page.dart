import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_medications_provider.dart';
import 'package:phmss_patient_app/models/medication.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

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
      appBar: AppBar(
        title: Text("Medications"),
      ),
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
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
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
                            Center(
                              child: CachedNetworkImage(
                                imageUrl: medication.imageUrl.toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 200,
                                  width: 200,
                                  child: PhotoView(
                                      backgroundDecoration: BoxDecoration(),
                                      imageProvider: imageProvider),
                                ),
                                placeholder: (context, url) => SkeletonItem(
                                    child: Container(
                                  height: 200,
                                  width: 200,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                )),
                                errorWidget: (context, url, error) =>
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                                      child: Icon(Icons.error,size: 50),
                                    ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${medication.name}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Dosage - ${medication.dosage}"),
                                  Text("Frequency - ${medication.frequency}"),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("${medication.description}"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                      ),
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(),
                // color: Colors.amber,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${medication.name}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
