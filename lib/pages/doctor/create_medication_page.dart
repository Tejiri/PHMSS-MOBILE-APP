import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_illnesses_provider.dart';
import 'package:phmss_patient_app/Providers/user_provider.dart';
import 'package:phmss_patient_app/api/api.dart';
import 'package:phmss_patient_app/controllers/random.dart';
import 'package:phmss_patient_app/custom_widgets/alert.dart';
import 'package:phmss_patient_app/models/illness.dart';
import 'package:phmss_patient_app/models/user.dart';
import 'package:provider/provider.dart';

class CreateMedicationPage extends StatefulWidget {
  const CreateMedicationPage({super.key});

  @override
  State<CreateMedicationPage> createState() => _CreateMedicationPageState();
}

class _CreateMedicationPageState extends State<CreateMedicationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // List<String> items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  int? selectedIllness;

  TextEditingController medicationName = TextEditingController();
  TextEditingController medicationFrequency = TextEditingController();
  TextEditingController medicationDosage = TextEditingController();
  TextEditingController medicationDescription = TextEditingController();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  bool isLoading = false;
  bool imagePreviewLoading = false;

  // List downloadURLS = [];
  // List videoThumbnailURLS = [];
  // var senderRSSN;
  // var portfolio;
  // var postBy;

  // var selectedType = 'IMAGE';
  List selectedFiles = [];
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create medication"),
      ),
      body: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(image: decorationImageBackground),
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          Container(
            // height: ,

            decoration: BoxDecoration(
                // color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imagePreviewLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            // backgroundColor: greenRenMissColor,
                            color: Colors.blueAccent,
                          ),
                        )
                      : selectedFiles.length == 0
                          ? Container(
                              height: 180,
                              child:
                                  Image.asset('assets/images/placeholder.jpg'),
                            )
                          : Container(
                              height: 180,
                              margin: EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedFiles.length,
                                  itemBuilder: (context, index) {
                                    PlatformFile platformFile =
                                        selectedFiles[index];
                                    File file =
                                        File(platformFile.path.toString());
                                    return addImageView(
                                        file: file, index: index);
                                  }),
                            ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<int>(
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Select Illness',
                          ),
                          items: Provider.of<PatientIllnessProvider>(context)
                              .illnesses
                              .map((Illness illness) {
                            return DropdownMenuItem<int>(
                              value: illness.id,
                              child: Text(illness.name!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedIllness = value;
                          },
                        ),
                        // DropdownButton<String>(
                        //   value: selectedIllness,
                        //   hint: Text('Select an item'),
                        //   items: items.map((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        //   onChanged: (String? newValue) {
                        //     setState(() {
                        //       selectedIllness = newValue;
                        //     });
                        //   },
                        // ),
                        TextField(
                            maxLines: 1,
                            controller: medicationName,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                focusedBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                hintText: 'Enter medication name')),
                        TextField(
                            maxLines: 1,
                            controller: medicationFrequency,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                focusedBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                hintText: 'Enter medication frequency')),
                        TextField(
                            maxLines: 1,
                            controller: medicationDosage,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                focusedBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                hintText: 'Enter medication dosage')),
                        TextField(
                            minLines: 1,
                            maxLines: 5,
                            controller: medicationDescription,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                focusedBorder: UnderlineInputBorder(
                                    // borderSide:
                                    //     BorderSide(color: greenRenMissColor),
                                    ),
                                hintText: 'Enter medication description')),
                      ],
                    ),
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                createMedication(
                                    illnessId: selectedIllness, user: user);
                                if (selectedIllness == null) {
                                  bottomAlert(
                                      context: context,
                                      isError: true,
                                      title: "Illness not selected",
                                      message:
                                          "Please Select an illness to proceed");
                                }
                                print(selectedIllness);
                                print("Dnsdnsdinds");
                              },
                              child: Text("POST")))
                    ],
                  )
                ],
              ),
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        overlayOpacity: 0.5,
        // overlayColor: Colors.transparent,
        children: [
          SpeedDialChild(
            label: 'Upload Image',
            child: selectFileIcon(icon: Icons.image, type: 'IMAGE'),
          ),
          // SpeedDialChild(
          //   label: 'Upload Videos',
          //   child: selectFileIcon(icon: Icons.video_camera_back, type: 'VIDEO'),
          // ),
        ],
      ),
    );
  }

  selectFileIcon({required icon, required type}) {
    return GestureDetector(
      onTap: () async {
        if (type == 'IMAGE') {
          setState(() {
            imagePreviewLoading = true;
          });
          FilePickerResult? result = await FilePicker.platform
              .pickFiles(allowMultiple: false, type: FileType.image);

          if (result != null) {
            print(selectedFiles);
            setState(() {
              selectedFiles = result.files;
              imagePreviewLoading = false;
            });
          } else {
            print(selectedFiles);
            setState(() {
              selectedFiles = [];
              imagePreviewLoading = false;
            });
            // User canceled the picker
          }
        }
      },
      child: CircleAvatar(
        // backgroundColor: blueRenMissColor,
        // selectedType == type ? greenRenMissColor : Colors.white,
        radius: 25,
        // minRadius: 10,

        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Icon(icon, color: Colors.white

                //  selectedType == type ? : greenRenMissColor,
                )),
      ),
    );
  }

  Widget addImageView({required file, required index}) {
    return Container(
      height: 180,
      width: 180,
      margin: EdgeInsets.only(right: 15),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              // decoration:
              // BoxDecoration(borderRadius: BorderRadius.circular(25)),
              height: 180,
              width: 180,
              // margin: EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  file,
                  // width: 80,
                  // height: 80,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            // height: 200,
            // width: 200,
            margin: EdgeInsets.only(right: 5, top: 5),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  selectedFiles.removeAt(index);
                  setState(() {});
                },
                child: CircleAvatar(
                  backgroundColor:
                      Color.fromARGB(255, 0, 80, 3).withOpacity(0.5),
                  radius: 15,
                  // minRadius: 10,

                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  createMedication({required User? user, required illnessId}) async {
    setState(() {
      isLoading = true;
    });
    if (selectedFiles.length < 1 ||
        selectedIllness == null ||
        medicationName.text.isEmpty ||
        medicationFrequency.text.isEmpty ||
        medicationDosage.text.isEmpty ||
        medicationDescription.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      bottomAlert(
          context: context,
          isError: true,
          title: "Error",
          message: "Fill all the required information to continue");
    } else {}
    for (var selectedItem in selectedFiles) {
      PlatformFile platformFile = selectedItem;
      File item = File(platformFile.path.toString());
      await FirebaseStorage.instance
          .ref()
          .child(
              "images/${user?.id}/" + generateRandomString(len: 10, user: user))
          .putFile(item)
          .then((value) async {
        await value.ref.getDownloadURL().then((imageURL) async {
          await Api()
              .createMedication(
                  context: context,
                  illnessId: illnessId,
                  name: medicationName.text,
                  description: medicationDescription.text,
                  dosage: medicationDosage.text,
                  frequency: medicationFrequency.text,
                  imageUrl: imageURL)
              .then((value) {
            setState(() {
              isLoading = false;
            });

            });
          // FirebaseFirestore.instance
          //     .collection("images")
          //     .add({'imageURL': imageURL});
        });
      });
    }

    var userPostFiles = [];
  }
}
